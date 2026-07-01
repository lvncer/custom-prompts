# Git Worktree 作成（既存リモートブランチ）

## 概要

リモートにすでにあるブランチから worktree を作成する。

## 入力

- 対象ブランチ名（ユーザーが指定）

## 手順

### 1. bare リポジトリを特定

```sh
ls *.git 2>/dev/null || git rev-parse --git-dir
```

### 2. worktree 一覧を確認

```sh
git worktree list
```

### 3. リモート参照を同期

```sh
git --git-dir <bare-repo-path> fetch --prune origin
git --git-dir <bare-repo-path> update-ref refs/heads/<branch> refs/remotes/origin/<branch>
```

### 4. worktree ディレクトリ名を決める

ブランチ名の `/` を `-` に置換（`feature/foo` → `feature-foo`）。

### 5. worktree を作成

bare 側にローカルブランチがない場合:

```sh
git --git-dir <bare-repo-path> worktree add --track -b <branch> <workspace-root>/<branch-with-slash-replaced> origin/<branch>
```

bare 側にすでにローカルブランチがある場合:

```sh
git --git-dir <bare-repo-path> worktree add --track <workspace-root>/<branch-with-slash-replaced> <branch>
```

### 6. worktree 内で最新を取得

```sh
cd <workspace-root>/<branch-with-slash-replaced>
git pull origin <branch>
```

すでに最新なら `Already up to date.` のみで問題なし。
