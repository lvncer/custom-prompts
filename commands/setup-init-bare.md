# bare リポジトリでの初期セットアップ

## 概要

新規プロジェクトを bare リポジトリ + worktree 構成でセットアップする。
ワークスペースルートに `.claude/` `.cursor/` `CLAUDE.md` `.mcp.json` `skills-lock.json` を配置し、bare clone、skills インストール、`main` worktree 作成までを一括で行う。
GitKraken MCP を最優先で使い、足りない操作だけ `git` を使う。

`.cursor` が無い場所でこのコマンド自体は呼べない（配布の鶏卵問題）。すでに `.cursor` が使えるディレクトリ（別プロジェクトの workspace-root や、このリポジトリ自身）から実行し、隣に新しいワークスペースを作る運用を想定する。

## 完成形

```txt
<workspace-root>/
├── .claude/              # ai-configs から配布
├── .cursor/               # ai-configs から配布
├── .agents/                # skills インストール後に自動生成
├── CLAUDE.md
├── .mcp.json
├── skills-lock.json
├── <project>.git/        # bare clone したリポジトリ
└── main/                   # main ブランチの worktree
```

## 入力

| input             | required | 内容                                                                 |
| ----------------- | -------- | --------------------------------------------------------------------- |
| repo_url           | true     | bare clone するリポジトリの URL                                       |
| workspace_root      |          | ワークスペースルートのパス（未指定ならカレントディレクトリ）           |
| project_name        |          | bare リポジトリのディレクトリ名（未指定なら `repo_url` から推測）      |

ドキュメント上の `<repo_url>` 等の文言は**そのままコマンドに貼らない**。ユーザー入力に置き換える。

## 手順

### 1. ワークスペースルートを準備する

```sh
mkdir -p "<workspace-root>"
cd "<workspace-root>"
```

既存ファイルがある場合は上書きしないよう、事前に `ls -la` で確認する。

### 2. リポジトリを bare clone する

- `gitkraken_git_clone` があれば優先して使う（bare オプションが無ければ `git` にフォールバック）。
- `project_name` が未指定なら `repo_url` の末尾（`.git` を除いたリポジトリ名）を使う。

```sh
git clone --bare "<repo_url>" "<workspace-root>/<project_name>.git"
```

### 3. remote-tracking の設定を補う

`git clone --bare` は `refs/remotes/origin/*` を作らず、ブランチを直接 `refs/heads/*` にミラーする。
以後 `worktree-create-new-branch` / `worktree-create-already-onremote` など他コマンドが `fetch origin` で新規リモートブランチを拾えるよう、明示的に fetch 設定を追加する。

```sh
git --git-dir="<workspace-root>/<project_name>.git" config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
git --git-dir="<workspace-root>/<project_name>.git" fetch --prune origin
```

### 4. ai-configs テンプレートから `.claude` `.cursor` を取得する

```sh
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b main git@github.com:lvncers-template/ai-configs.git "$tmp_dir/ai-configs"

cp -R "$tmp_dir/ai-configs/.claude" "<workspace-root>/.claude"
cp -R "$tmp_dir/ai-configs/.cursor" "<workspace-root>/.cursor"
cp "$tmp_dir/ai-configs/.claude/CLAUDE.md" "<workspace-root>/CLAUDE.md"
cp "$tmp_dir/ai-configs/.mcp.json" "<workspace-root>/.mcp.json"
```

対象は新規ワークスペースなので上書きガードは不要（既存ワークスペースへの再配布は `documents/SETUP.md` を使う）。

### 5. skills をインストールする

```sh
cd "<workspace-root>"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

### 6. `main` を worktree として作成する

bare clone した時点で `refs/heads/main` は直接ミラーされているため、追加の fetch なしで worktree 化できる。

- `git_worktree`（`action: "add"`）があれば優先して使う。

```sh
git --git-dir="<workspace-root>/<project_name>.git" worktree add "<workspace-root>/main" main
```

### 7. 確認

- `gitkraken_workspace_list` または以下で確認する。

```sh
git --git-dir="<workspace-root>/<project_name>.git" worktree list
ls -la "<workspace-root>"
```

`.claude` `.cursor` `.agents` `CLAUDE.md` `.mcp.json` `skills-lock.json` `<project_name>.git` `main` が揃っていることを報告する。

## gitignore（配布先リポジトリ側）

`documents/SETUP.md` の tarball / clone パターンと同様、`main` worktree 内の `.gitignore` に追記する。

```gitignore
.claude/
.cursor/
.agents/
CLAUDE.md
skills-lock.json
```

`.mcp.json` はプレースホルダを埋めた実体をコミット管理するため gitignore しない。
