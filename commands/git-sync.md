# Git 同期とプッシュ解決

## 概要

リモートの変更によりプッシュが拒否された場合の一般的な git 同期の問題を解決する。
git の状態を分析し、最新の変更をプルし、競合を解決する。

## 手順

### 1. 状態分析

```sh
git status
git log --oneline -10
```

- 未コミットの変更を特定
- ブランチの追跡情報を確認

### 2. 同期前の準備

- ローカルの変更を stash またはコミット

  ```sh
  # stash の場合
  git stash

  # コミットの場合
  git add <files>
  git commit -m "chore: WIP"
  ```

- リモートの変更を fetch

  ```sh
  git fetch origin
  ```

- ローカルとリモートのブランチを比較

  ```sh
  git log HEAD..origin/ < branch > --oneline
  ```

### 3. プルとマージ解決

```sh
git pull origin <ブランチ名>
```

マージ競合が発生した場合はユーザーに依頼する。

### 4. 競合解決（必要な場合）

```sh
git status
```

競合ファイルを特定後、手動で解決。

```sh
git add <解決したファイル>
git commit -m "merge: 競合を解決"
```
