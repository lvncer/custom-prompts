# Cursor 同期（clone）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に `git clone` で取得した `.cursor` と skills を一方向配布する。Cursor の起動はしない。

tarball 版は [/cursor-sync-tarball](/.cursor/commands/cursor-sync-tarball.md)。
submodule 版は [/cursor-sync-open](/.cursor/commands/cursor-sync-open.md)。

## 前提

- Cursor は `<workspace-root>` を開いている（`.cursor/commands/` が使える状態）
- 対象 worktree は `<workspace-root>` 直下のディレクトリ
- `git` とリモートへの認証（SSH または HTTPS）が使えること

```txt
<workspace-root>/
├── .cursor/           ← コマンド実行元（ここ）
├── <project>.git/
└── <target>/          ← 配布先 worktree
```

worktree に `.cursor` が無くてもこのコマンドは実行できる（配布が目的）。

## 定数

```txt
CURSOR_TEMPLATE_REPO=git@github.com:lvncers-template/ai-configs.git
CURSOR_TEMPLATE_BRANCH=main
```

HTTPS を使う場合は `CURSOR_TEMPLATE_REPO` を `https://github.com/lvncers-template/ai-configs.git` に置き換える。

## 入力

| input            | required | 内容                                            |
| ---------------- | -------- | ----------------------------------------------- |
| `workspace_root` | true     | ワークスペースルートの絶対パス                  |
| `target`         | true     | 配布先（worktree ディレクトリ名または絶対パス） |

`target` が相対パスのときは `"${workspace_root}/${target}"` に解決する。

## 実行フロー

```txt
1. target_path を解決
2. shallow clone から .cursor を target_path にコピー
3. target_path で skills を同期
```

## 手順

### 一括実行（推奨）

```sh
set -euo pipefail

workspace_root="/path/to/workspace"
target="feature-A"
target_path="${workspace_root}/${target}"

CURSOR_TEMPLATE_REPO="git@github.com:lvncers-template/ai-configs.git"
CURSOR_TEMPLATE_BRANCH="main"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b "$CURSOR_TEMPLATE_BRANCH" \
  "$CURSOR_TEMPLATE_REPO" \
  "$tmp_dir/ai-configs"

rm -rf "${target_path}/.cursor"
cp -R "$tmp_dir/ai-configs/.cursor" "${target_path}/"

cd "$target_path"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json skills-lock.json
npx skills experimental_install
```

### 1. `.cursor` を clone で配布

```sh
set -euo pipefail

target_path="/path/to/workspace/feature-A"
CURSOR_TEMPLATE_REPO="git@github.com:lvncers-template/ai-configs.git"
CURSOR_TEMPLATE_BRANCH="main"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b "$CURSOR_TEMPLATE_BRANCH" \
  "$CURSOR_TEMPLATE_REPO" \
  "$tmp_dir/ai-configs"

rm -rf "${target_path}/.cursor"
cp -R "$tmp_dir/ai-configs/.cursor" "${target_path}/"
```

### 2. Skills を同期

```sh
cd "$target_path"

rm -rf .cursor/.agents
cp .cursor/skills-lock.json skills-lock.json
npx skills experimental_install
```

## worktree 用 gitignore

配布先 worktree の `.gitignore` に追記:

```gitignore
.cursor/
.agents/
skills-lock.json
```

## エラー対応

| 症状                         | 対処                                                               |
| ---------------------------- | ------------------------------------------------------------------ |
| `.cursor` が submodule       | `git submodule deinit -f .cursor` → `git rm -f .cursor` 後に再実行 |
| clone 認証失敗               | SSH 鍵または HTTPS トークンを確認                                  |
| スラッシュコマンドが使えない | Cursor が `workspace_root` を開いているか確認                      |

## tarball との使い分け

|                | clone                                    | tarball                             |
| -------------- | ---------------------------------------- | ----------------------------------- |
| 必要なもの     | `git` + 認証                             | `curl` + `tar`                      |
| 向いている場面 | Git 認証が済んでいる、clone に慣れている | curl だけで済ませたい、Git 履歴不要 |

## 特性

- 一方向（upstream → worktree）
- worktree リポジトリに `.cursor` は載らない（gitignore 前提）
- ローカル変更は `rm -rf .cursor` で消える
- `--depth 1` の一時 clone は配布後に削除する（worktree 内に ai-configs 全体は残さない）
