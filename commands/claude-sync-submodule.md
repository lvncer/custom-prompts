# Claude Code 同期（submodule）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に `.claude` submodule と `CLAUDE.md` を配布する。

一方向の tarball 配布は [/claude-sync-tarball](/.claude/commands/claude-sync-tarball.md)。
clone 版は [/claude-sync-clone](/.claude/commands/claude-sync-clone.md)。

## 定数

```txt
CLAUDE_SUBMODULE_PATH=.claude
CLAUDE_TEMPLATE_REPO=git@github.com:lvncers-template/ai-configs.git
CLAUDE_TEMPLATE_BRANCH=main
```

## 入力

| input            | required | 内容                                            |
| ---------------- | -------- | ----------------------------------------------- |
| `workspace_root` | true     | ワークスペースルートの絶対パス                  |
| `target`         | true     | 配布先（worktree ディレクトリ名または絶対パス） |

## 手順

### 1. submodule を同期

```sh
cd "$target_path"
git submodule update --init --remote .claude
```

初回のみ:

```sh
cd "$target_path"
git submodule add -b main \
  git@github.com:lvncers-template/ai-configs.git \
  .claude
```

### 2. CLAUDE.md をコピー

```sh
cp .claude/CLAUDE.md ./CLAUDE.md
```

## Git 管理の境界（worktree 側）

| パス          | worktree リポジトリ |
| ------------- | ------------------- |
| `.claude/`    | submodule 参照のみ  |
| `CLAUDE.md`   | gitignore           |
| `.gitmodules` | コミット対象        |

## エラー対応

| 症状                                    | 対処                                    |
| --------------------------------------- | --------------------------------------- |
| `.claude` exists but is not a submodule | `rm -rf .claude` してから submodule add |
| `fatal: not a git repository`           | `target_path` が worktree か確認        |
