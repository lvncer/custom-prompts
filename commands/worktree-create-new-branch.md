# Git Worktree 作成（新規ブランチ）

## 概要

新規ブランチを切って worktree を作成する。

## 入力

| input  | required | 内容                                                       |
| ------ | -------- | ---------------------------------------------------------- |
| task   | true     | ユーザーが指定する作業内容の説明                           |
| branch |          | 新規ブランチ名（未指定なら手順 4 で決める）                |
| base   |          | 分岐元（省略時は `origin/main`。`<remote>/<branch>` 形式） |

## 手順

### 1. bare リポジトリを特定する

```sh
ls *.git 2> /dev/null || git rev-parse --git-dir
```

### 2. worktree 一覧を確認する

```sh
git worktree list
```

### 3. リモート参照を同期する

```sh
git --git-dir --prune origin < bare-repo-path > fetch
```

### 4. ブランチ名を決める

`branch` が指定されていればそれを使う。
未指定なら `CONTRIBUTING.md` / `.github/CONTRIBUTING.md` を確認し、なければプロジェクト慣例で命名する。

### 5. worktree ディレクトリ名を決める

ブランチ名の `/` を `-` に置換（`feature/foo` → `feature-foo`）。

### 6. 新規ブランチで worktree を作成する

```sh
git --git-dir <bare-repo-path> worktree add -b <branch> <workspace-root>/<branch-with-slash-replaced> <base-branch>
```

### 7. worktree 内で最新を取得（必要なとき）

```sh
cd <workspace-root>/<branch-with-slash-replaced>
git pull origin <branch>
```

- すでに最新なら `Already up to date.` のみで問題なし
- 初回 push 前でリモートにブランチがない場合は skip
