# Git Submodule 削除

## 概要

ユーザーが「submoduleを削除して」「`.cursor`を消して」など**明確に削除を指示した**場合に、指定されたsubmoduleを安全に削除する。

`git rm` だけでは削除できない（`.git/modules` に内部管理データが残る）ため、専用の手順を踏む。

## 前提

- 削除対象はユーザーが指定したsubmoduleのパス（例: `.cursor`）
- 事前に `.gitmodules` と `git submodule status` で対象が存在するか確認する

## 手順

### 1. 対象の確認

```sh
cat .gitmodules
git submodule status
```

### 2. submoduleの登録解除

作業ツリーごと削除される。

```sh
git submodule deinit -f -- <path>
```

### 3. 内部管理データの削除

`.git/modules` 配下に残る管理データを削除する。

```sh
rm -rf ".git/modules/<path>"
```

### 4. gitlinkとインデックスから削除

```sh
git rm -f <path>
```

最近のgitであれば `.gitmodules` の該当セクションも自動的に削除され、stageされる。

### 5. `.gitmodules` の残存確認

```sh
git status --short
cat .gitmodules
```

`<path>` のセクションが残っていたら手動で削除し、`git add .gitmodules` する。

### 6. コミット

```sh
git commit -m "Remove <path> submodule"
```

## 注意

- `.claude` / `.cursor` はこのリポジトリ（ai-configs）が配布元。配布先プロジェクト側で削除する場合と、ai-configs自体からsubmodule定義を削除する場合を混同しない。
- 配布先プロジェクトでの削除は、そのプロジェクトのリポジトリに対してこの手順を実行するだけでよい（ai-configs側の変更は不要）。
