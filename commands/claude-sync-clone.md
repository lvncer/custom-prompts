# Claude Code 同期（clone）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に `git clone` で取得した `.claude` と `CLAUDE.md` を一方向配布する。

tarball 版は [/claude-sync-tarball](/.claude/commands/claude-sync-tarball.md)。
submodule 版は [/claude-sync-submodule](/.claude/commands/claude-sync-submodule.md)。

## 前提

- `.claude/commands/` が使える状態
- 対象 worktree は `<workspace-root>` 直下のディレクトリ
- `git` とリモートへの認証（SSH または HTTPS）が使えること

```txt
<workspace-root>/
├── .claude/           ← コマンド実行元（ここ）
├── <project>.git/
└── <target>/          ← 配布先 worktree
```

## 定数

```txt
CLAUDE_TEMPLATE_REPO=git@github.com:lvncers-template/ai-configs.git
CLAUDE_TEMPLATE_BRANCH=main
```

HTTPS を使う場合は `CLAUDE_TEMPLATE_REPO` を `https://github.com/lvncers-template/ai-configs.git` に置き換える。

## 入力

| input            | required | 内容                                            |
| ---------------- | -------- | ----------------------------------------------- |
| `workspace_root` | true     | ワークスペースルートの絶対パス                  |
| `target`         | true     | 配布先（worktree ディレクトリ名または絶対パス） |

`target` が相対パスのときは `"${workspace_root}/${target}"` に解決する。

## 手順

### 一括実行（推奨）

```sh
set -euo pipefail

workspace_root="/path/to/workspace"
target="feature-A"
target_path="${workspace_root}/${target}"

CLAUDE_TEMPLATE_REPO="git@github.com:lvncers-template/ai-configs.git"
CLAUDE_TEMPLATE_BRANCH="main"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b "$CLAUDE_TEMPLATE_BRANCH" \
  "$CLAUDE_TEMPLATE_REPO" \
  "$tmp_dir/ai-configs"

rm -rf "${target_path}/.claude"
cp -R "$tmp_dir/ai-configs/.claude" "${target_path}/"
cp "$tmp_dir/ai-configs/CLAUDE.md" "${target_path}/CLAUDE.md"
```

## worktree 用 gitignore

配布先 worktree の `.gitignore` に追記:

```gitignore
.claude/
CLAUDE.md
```

## エラー対応

| 症状                   | 対処                                                               |
| ---------------------- | ------------------------------------------------------------------ |
| clone 認証失敗         | SSH 鍵または HTTPS トークンを確認                                  |
| `.claude` が submodule | `git submodule deinit -f .claude` → `git rm -f .claude` 後に再実行 |
