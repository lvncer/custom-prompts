# Cursor 同期と起動

## 概要

worktree 作成後に `.cursor` を反映し、Cursor を起動する。

**必ず `origin` の最新で作業したい場合**は、`worktree-create-*` 側の「worktree 内で最新を取得」（`git pull origin <branch>` など）を先に済ませてから、このコマンドに進む（ここでは pull はしない）。

## 入力

このコマンドは基本的に `worktree-create-*` の直後に連続して使う。
そのため、`branch` と `worktree_path` は、直前の `worktree-create` の入力/規則から推測する。
推測が難しい場合は、bare リポジトリで `git_worktree`（`action: "list"`）を実行し、対象ブランチの worktree パスを拾う。

## 手順

### 1. `.cursor` を反映

```sh
branch="<branch>"
task="<task>"
worktree_path="<workspace-root>/<branch-with-slash-replaced>"

tmp_dir="$(mktemp -d)"
curl -L https://github.com/lvncer/ai-configs/archive/refs/heads/main.tar.gz -o "$tmp_dir/ai-configs-main.tar.gz"
tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"
rm -rf "$worktree_path/.cursor"
cp -R "$tmp_dir/ai-configs-main/.cursor" "$worktree_path/.cursor"
rm -rf "$tmp_dir"
```

### 2. Cursor で起動

```sh
cursor "$worktree_path"

if [ -n "$task" ]; then
  prompt_text="ブランチ ${branch} で ${task} の作業を続けてください。"
else
  prompt_text="ブランチ ${branch} の作業を続けてください。"
fi

open "cursor://anysphere.cursor-deeplink/prompt?text=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$prompt_text")"
```
