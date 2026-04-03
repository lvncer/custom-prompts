# Cursor 同期と起動

## 概要

worktree 作成後に `.cursor` を反映し、`skills-lock.json` に沿って skills を同期してから Cursor を起動する。

**必ず `origin` の最新で作業したい場合**は、`worktree-create-*` 側の「worktree 内で最新を取得」（`git pull origin <branch>` など）を先に済ませてから、このコマンドに進む（ここでは pull はしない）。

## 入力

このコマンドは基本的に `worktree-create-*` の直後に連続して使う。
そのため、`branch` と `worktree_path` は、直前の `worktree-create` の入力/規則から推測する。
推測が難しい場合は、bare リポジトリで `git_worktree`（`action: "list"`）を実行し、対象ブランチの worktree パスを拾う。

## 手順

### 1. `.cursor` を反映

```sh
set -e

branch="feature/hoge"
worktree_path="/path/to/workspace/${branch//\//-}"

tmp_dir="$(mktemp -d)"

curl -fL https://github.com/lvncer/ai-configs/archive/refs/heads/main.tar.gz \
  -o "$tmp_dir/ai-configs-main.tar.gz"

tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"

if [ -d "$worktree_path/.cursor" ]; then
  rm -rf "$worktree_path/.cursor"
fi

mkdir -p "$worktree_path"
cp -R "$tmp_dir/ai-configs-main/.cursor" "$worktree_path/"

rm -rf "$tmp_dir"
```

### 2. Skills をインストール

skills 一覧のバージョン管理はリポジトリ直下の `skills-lock.json` を使用している。
同期は worktree ルートで下記を実行する。
現状は実験段階であり、実行コマンドが変わる可能性がある。

```sh
cd "$worktree_path"
npx skills experimental_install
```

### 3. Cursor で起動

```sh
cursor "$worktree_path"

prompt_text="現在のブランチは ${branch} です。ここで作業を開始してください。"

open "cursor://anysphere.cursor-deeplink/prompt?text=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$prompt_text")"
```
