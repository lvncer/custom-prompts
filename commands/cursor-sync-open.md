# Cursor 同期（submodule）

## 役割

**ワークスペースルート** から実行する AI 向け仕様。
対象 worktree に `.cursor` submodule と skills を配布する。Cursor の起動はしない。

一方向の tarball 配布は [/cursor-sync-tarball](/.cursor/commands/cursor-sync-tarball.md)。

## 前提

- Cursor は `<workspace-root>` を開いている（`.cursor/commands/` が使える状態）
- 対象 worktree は `<workspace-root>` 直下の Git 作業ツリー

```txt
<workspace-root>/
├── .cursor/           ← コマンド実行元（ここ）
├── <project>.git/
└── <target>/          ← 配布先 worktree
```

## 定数

```txt
CURSOR_SUBMODULE_PATH=.cursor
CURSOR_TEMPLATE_REPO=git@github.com:lvncers-template/ai-configs.git
CURSOR_TEMPLATE_BRANCH=cursor-export
SKILLS_LOCK_SOURCE=.cursor/skills-lock.json
SKILLS_LOCK_TARGET=skills-lock.json
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
2. target_path で submodule を add または update
3. target_path で skills を同期
```

## 手順

### 1. submodule を同期

```sh
cd "$target_path"
git submodule update --init --remote .cursor
```

初回のみ:

```sh
cd "$target_path"
git submodule add -b cursor-export \
  git@github.com:lvncers-template/ai-configs.git \
  .cursor
```

### 2. Skills を同期

```sh
cd "$target_path"

rm -rf .cursor/.agents
cp .cursor/skills-lock.json skills-lock.json
npx skills experimental_install
```

## エラー対応

| 症状                                    | 対処                                                                       |
| --------------------------------------- | -------------------------------------------------------------------------- |
| `.cursor` exists but is not a submodule | tarball 残骸。`rm -rf .cursor` してから submodule add                      |
| `fatal: not a git repository`           | `target_path` が worktree か確認                                           |
| skills が効かない                       | `.cursor/` 内で install していないか確認。ルートで cp + install をやり直す |
| スラッシュコマンドが使えない            | Cursor が worktree ではなく `workspace_root` を開いているか確認            |

## Git 管理の境界（worktree 側）

| パス                            | worktree リポジトリ |
| ------------------------------- | ------------------- |
| `.cursor/`                      | submodule 参照のみ  |
| `.gitmodules`                   | コミット対象        |
| `.agents/` / `skills-lock.json` | gitignore           |
