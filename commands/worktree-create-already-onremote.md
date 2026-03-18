# Git Worktree 作成（既存リモートブランチ）

## 概要

リモートにすでにあるブランチから worktree を作成する。
**GitKraken MCP を最優先**で使い、足りない操作だけ `git` を使う。

## 入力

- `branch: fix/556-add-favicon-control-pc`

## 手順

### 1. bare リポジトリを特定

- `gitkraken_workspace_list` を優先して使う。
- bare リポジトリ名は実ディレクトリ名を使う（例: `Project.git`）。

### 2. worktree 一覧を確認

- `git_worktree`（`action: "list"`）を使う。
- 出力不足時のみ `git worktree list` を使う。

### 3. リモート参照を同期

worktree 作成前に bare リポジトリで最新を取得する。
必要なら bare 側のローカル参照も `origin/<branch>` に合わせる。

```sh
git --git-dir <bare-repo-path> fetch --prune origin
git --git-dir <bare-repo-path> update-ref refs/heads/<branch> refs/remotes/origin/<branch>
```

### 4. worktree ディレクトリ名を決める

ディレクトリ名はブランチ名の `/` を `-` に置換する。

- 例: `fix/556-add-favicon-control-pc` -> `fix-556-add-favicon-control-pc`

### 5. worktree を作成

- bare 側にローカルブランチがない場合:

```sh
git --git-dir <bare-repo-path> worktree add --track -b <branch> <workspace-root>/<branch-with-slash-replaced> origin/<branch>
```

- bare 側にすでにローカルブランチがある場合:

```sh
git --git-dir <bare-repo-path> worktree add --track <workspace-root>/<branch-with-slash-replaced> <branch>
```
