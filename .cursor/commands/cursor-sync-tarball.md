# Cursor 同期と起動（tarball）

## 役割

worktree 作成後に tarball から `.cursor` を一方向同期し、skills をインストールして Cursor を起動する。
submodule で双方向管理したい場合は [/cursor-sync-open](/.cursor/commands/cursor-sync-open.md) を使う。

## 定数

```txt
CURSOR_DIR=.cursor
TEMPLATE_TARBALL_URL=https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz
TARBALL_ROOT_DIR=ai-configs-main
SKILLS_LOCK_SOURCE=.cursor/skills-lock.json
SKILLS_LOCK_TARGET=skills-lock.json
AGENTS_DIR=.agents
```

## アーキテクチャ

```txt
親リポジトリ
  ├── .cursor/             ← tarball で上書き（Git 管理外）
  ├── skills-lock.json     ← ルートにコピー（Git 管理外）
  └── .agents/skills/      ← experimental_install の生成物（Git 管理外）
```

### Git 管理の境界

| パス                         | 親リポジトリ | 説明                                          |
| ---------------------------- | ------------ | --------------------------------------------- |
| `.cursor/`                   | gitignore    | 毎回 tarball で全上書き。ローカル変更は消える |
| `.agents/`                   | gitignore    | 生成物                                        |
| `skills-lock.json`（ルート） | gitignore    | `.cursor/skills-lock.json` のコピー           |

### Skills CLI の制約

`npx skills experimental_install` は **プロジェクトルート** で実行する。

- 読む: `./skills-lock.json`
- 書く: `./.agents/skills/`
- `.cursor/` 内で実行すると `.cursor/.agents/` ができ、Cursor は認識しない

## 入力

`worktree-create-*` の直後に使うことが多い。

- `branch`: 作業ブランチ名（例: `feature/hoge`）
- `worktree_path`: worktree の絶対パス

推測できない場合は bare リポジトリで `git_worktree`（`action: "list"`）を実行し、対象ブランチの worktree パスを取得する。

**プロジェクト本体を最新にしたい場合**は、このコマンドの前に worktree 内で `git pull origin <branch>` を済ませる。

## 実行フロー

```txt
1. worktree_path に cd
2. tarball を取得して .cursor を上書き
3. skills を同期（ルートで cp + experimental_install）
4. Cursor を起動
```

## 手順

### 1. `.cursor` を tarball で反映

```sh
set -euo pipefail

worktree_path="/path/to/workspace/feature-hoge"
TEMPLATE_TARBALL_URL="https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz"

cd "$worktree_path"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl -fL "$TEMPLATE_TARBALL_URL" -o "$tmp_dir/ai-configs-main.tar.gz"
tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"

rm -rf .cursor
cp -R "$tmp_dir/ai-configs-main/.cursor" .
```

### 2. Skills を同期

```sh
cd "$worktree_path"

rm -rf .cursor/.agents

cp .cursor/skills-lock.json skills-lock.json
npx skills experimental_install
```

### 3. Cursor で起動

```sh
cursor "$worktree_path"

prompt_text="現在のブランチは ${branch} です。ここで作業を開始してください。"
open "cursor://anysphere.cursor-deeplink/prompt?text=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$prompt_text")"
```

## エラー対応

| 症状                                | 原因                         | 対処                                                                                   |
| ----------------------------------- | ---------------------------- | -------------------------------------------------------------------------------------- |
| `.cursor` が submodule になっている | submodule 方式と混在         | `git submodule deinit -f .cursor` → `git rm -f .cursor` → `.gitmodules` 整理後に再実行 |
| tarball 取得失敗                    | ネットワーク / URL           | URL と認証を確認                                                                       |
| skills が Cursor に出ない           | `.cursor/` 内で install した | `rm -rf .cursor/.agents`、ルートで cp + install をやり直す                             |

## tarball 方式の特性

- テンプレ取り込みは **一方向**（upstream → ローカル）
- `.cursor/` のローカル変更は `rm -rf .cursor` で消える
- 親リポジトリに `.cursor` は載らない（gitignore 前提）
