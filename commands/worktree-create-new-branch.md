# Git Worktree 作成（新規ブランチ）

## 概要

新規ブランチを切って worktree を作成する。
GitKraken MCP を最優先で使い、足りない操作だけ `git` を使う。

## 入力

| input  | required | example                          | default       |
| ------ | -------- | -------------------------------- | ------------- |
| task   | true     | `favicon 制御の追加`             |               |
| branch |          | `fix/556-add-favicon-control-pc` |               |
| base   |          | `origin/main`                    | `origin/main` |

## 手順

### 1. bare リポジトリを特定する

- `gitkraken_workspace_list` を優先して使う。
- bare リポジトリ名は実ディレクトリ名を使う（例: `Project.git`）。

### 2. worktree 一覧を確認する

- `git_worktree`（`action: "list"`）を使う。
- 出力不足時のみ `git worktree list` を使う。

### 3. リモート参照を同期する

```sh
git --git-dir --prune origin < bare-repo-path > fetch
```

### 4. ブランチ名を決める

`branch` が指定されていればそれを使う。
未指定なら命名規則を次の順で確認する。

1. `CONTRIBUTING.md`
2. `CONTRIBUTING`
3. `docs/CONTRIBUTING.md`
4. `.github/CONTRIBUTING.md`

見つからなければ `type/<issue-number>-<description>` 形式にする。

### 5. worktree ディレクトリ名を決める

ディレクトリ名はブランチ名の `/` を `-` に置換する。

- 例: `fix/556-add-favicon-control-pc` -> `fix-556-add-favicon-control-pc`

### 6. 新規ブランチで worktree を作成する

```sh
git --git-dir <bare-repo-path> worktree add -b <branch> <workspace-root>/<branch-with-slash-replaced> <base-branch>
```

### 7. worktree 内で最新を取得（必要なとき）

bare 側の `fetch` だけでは、状況によって worktree が **古い参照のまま** になることがある。リモートに追跡対象のブランチがあるなら、作成した worktree で `pull` すると確実に最新になる。

```sh
cd <workspace-root>/<branch-with-slash-replaced>
git pull origin <branch>
```

- すでに最新なら `Already up to date.` のみで問題なし。
- **初回 push 前**でリモートに `<branch>` がまだない場合は `git pull origin <branch>` は失敗する（その場合は push 後に同じ手順を実行するか、ベースだけ揃えたいなら `git fetch origin` などでよい）。
