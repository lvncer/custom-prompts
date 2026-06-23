# Cursor 同期（tarball）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に tarball で `.cursor` と skills を一方向配布する。Cursor の起動はしない。

submodule で双方向管理する場合は [/cursor-sync-open](/.cursor/commands/cursor-sync-open.md)。

## 前提

- Cursor は `<workspace-root>` を開いている（`.cursor/commands/` が使える状態）
- 対象 worktree は `<workspace-root>` 直下のディレクトリ

```txt
<workspace-root>/
├── .cursor/           ← コマンド実行元（ここ）
├── <project>.git/
└── <target>/          ← 配布先 worktree
```

worktree に `.cursor` が無くてもこのコマンドは実行できる（配布が目的）。

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

`target` が相対パスのときは `"${workspace_root}/${target}"` に解決する。

## 実行フロー

```txt
1. target_path を解決
2. tarball から .cursor を target_path に展開
3. target_path で skills を同期
```

## 手順

### 1. `.cursor` を tarball で配布

```sh
set -euo pipefail

target_path="/path/to/workspace/feature-A"
TEMPLATE_TARBALL_URL="https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl -fL "$TEMPLATE_TARBALL_URL" -o "$tmp_dir/ai-configs-main.tar.gz"
tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"

rm -rf "${target_path}/.cursor"
cp -R "$tmp_dir/ai-configs-main/.cursor" "${target_path}/"
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
| tarball 取得失敗             | URL・ネットワーク確認                                              |
| スラッシュコマンドが使えない | Cursor が `workspace_root` を開いているか確認                      |

## 特性

- 一方向（upstream → worktree）
- worktree リポジトリに `.cursor` は載らない（gitignore 前提）
- ローカル変更は `rm -rf .cursor` で消える
