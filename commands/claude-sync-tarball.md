# Claude Code 同期（tarball）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に tarball で `.claude` と `CLAUDE.md` を一方向配布する。

clone 版は [/claude-sync-clone](/.claude/commands/claude-sync-clone.md)。
submodule 版は [/claude-sync-submodule](/.claude/commands/claude-sync-submodule.md)。

## 前提

- `.claude/commands/` が使える状態
- 対象 worktree は `<workspace-root>` 直下のディレクトリ

## 定数

```txt
TEMPLATE_TARBALL_URL=https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz
TARBALL_ROOT_DIR=ai-configs-main
```

## 入力

| input            | required | 内容                                            |
| ---------------- | -------- | ----------------------------------------------- |
| `workspace_root` | true     | ワークスペースルートの絶対パス                  |
| `target`         | true     | 配布先（worktree ディレクトリ名または絶対パス） |

## 手順

```sh
set -euo pipefail

target_path="/path/to/workspace/feature-A"
TEMPLATE_TARBALL_URL="https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl -fL "$TEMPLATE_TARBALL_URL" -o "$tmp_dir/ai-configs-main.tar.gz"
tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"

rm -rf "${target_path}/.claude"
cp -R "$tmp_dir/ai-configs-main/.claude" "${target_path}/"
cp "$tmp_dir/ai-configs-main/CLAUDE.md" "${target_path}/CLAUDE.md"
```

## worktree 用 gitignore

```gitignore
.claude/
CLAUDE.md
```

## エラー対応

| 症状           | 対処                  |
| -------------- | --------------------- |
| tarball 取得失敗 | URL・ネットワーク確認 |
