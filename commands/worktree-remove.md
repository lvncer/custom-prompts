# Git Worktree 削除

## 概要

ユーザーが「削除して」「この worktree を消して」など**明確に削除を指示した**場合に、指定された worktree を安全に削除する。

## 前提

- 削除対象はユーザーが指定した worktree（パスまたは名前）
- 必要なら先に `worktree-list` で一覧・削除可否を確認してから実行する

## 手順

### 1. 削除対象の状態確認

```sh
git worktree list
cd <worktree-path> && git status
```

対象が lock されていないか、未コミット変更がないか確認する。

### 2. lock されている場合

lock されている worktree は、先に解除してから削除する。

```sh
git worktree unlock <path>
git worktree remove <path>
```

### 3. 通常削除

```sh
git worktree remove <path>
```

変更が残っていて削除できない場合は、まずコミットまたは stash を促す。
やむを得ない場合のみ `--force` を検討する。

### 4. 孤立参照の prune

ディレクトリ削除済みの参照が残っている場合:

```sh
git worktree prune --verbose
```

### 5. 最終確認

```sh
git worktree list
```
