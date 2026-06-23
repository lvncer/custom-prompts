# Cursor 同期と起動（submodule）

## 役割

このファイルは **AI 向け** の実行仕様。人間向けの概要は [SETUP.md](/documents/SETUP.md)。

worktree 作成後に `.cursor` submodule を同期し、skills をインストールして Cursor を起動する。

一方向の tarball 同期は [/cursor-sync-tarball](/.cursor/commands/cursor-sync-tarball.md) を使う。

## 定数

```txt
CURSOR_SUBMODULE_PATH=.cursor
CURSOR_TEMPLATE_REPO=git@github.com:lvncers-template/ai-configs.git
CURSOR_TEMPLATE_BRANCH=cursor-export
SKILLS_LOCK_SOURCE=.cursor/skills-lock.json
SKILLS_LOCK_TARGET=skills-lock.json
AGENTS_DIR=.agents
```

HTTPS を使う場合は `CURSOR_TEMPLATE_REPO` を `https://github.com/lvncers-template/ai-configs.git` に置き換える。

## アーキテクチャ

```txt
親リポジトリ
  ├── .gitmodules          ← submodule 定義（初回 add 時に作成）
  ├── .cursor/             ← submodule（cursor-export の中身がルート）
  │     └── skills-lock.json  ← skills マニフェストの正本
  ├── skills-lock.json     ← ルートにコピー（Git 管理外）
  └── .agents/skills/      ← experimental_install の生成物（Git 管理外）
```

### Git 管理の境界

| パス                         | 親リポジトリ       | 説明                                                       |
| ---------------------------- | ------------------ | ---------------------------------------------------------- |
| `.cursor/`                   | submodule 参照のみ | ファイル本体は submodule 内。`git submodule update` で更新 |
| `.gitmodules`                | コミット対象       | submodule URL・ブランチ定義                                |
| `.agents/`                   | gitignore          | 生成物                                                     |
| `skills-lock.json`（ルート） | gitignore          | `.cursor/skills-lock.json` のコピー                        |

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
2. .cursor submodule を初期化・更新（未登録なら add）
3. skills を同期（ルートで cp + experimental_install）
4. Cursor を起動
```

## 手順

### 1. `.cursor` submodule を同期

#### 初回（submodule 未登録）

```sh
git submodule add -b cursor-export \
  git@github.com:lvncers-template/ai-configs.git \
  .cursor
```

#### 更新（submodule 登録済み）

```sh
git submodule update --init --remote .cursor
```

#### fresh clone / worktree で submodule が空のとき

```sh
git submodule update --init --recursive
```

### 2. Skills を同期

毎回 submodule 同期のあとに実行する。

```sh
cd "$worktree_path"

rm -rf .cursor/.agents

cp .cursor/skills-lock.json skills-lock.json
npx skills experimental_install
```

`npx skills` は実験段階。コマンドが変わる可能性がある。

### 3. Cursor で起動

```sh
cursor "$worktree_path"

prompt_text="現在のブランチは ${branch} です。"
open "cursor://anysphere.cursor-deeplink/prompt?text=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$prompt_text")"
```

## エラー対応

| 症状                                               | 原因                                    | 対処                                                       |
| -------------------------------------------------- | --------------------------------------- | ---------------------------------------------------------- |
| `.cursor` exists but is not a registered submodule | tarball や手動コピーで `.cursor` がある | `rm -rf .cursor` してから `git submodule add`              |
| `fatal: not a git repository`                      | worktree_path が誤り                    | パスを確認                                                 |
| skills が Cursor に出ない                          | `.cursor/` 内で install した            | `rm -rf .cursor/.agents`、ルートで cp + install をやり直す |
| submodule が空                                     | init していない                         | `git submodule update --init --recursive`                  |

## `.cursor` 内のカスタム変更

submodule 内で編集した場合、変更は `.cursor/` リポジトリ側にコミットする（fork 利用時は push も可能）。
親リポジトリには submodule の参照コミット更新だけが載る。

テンプレート更新でコンフリクトが出たら、`.cursor/` 内で通常の Git merge を解消する。
