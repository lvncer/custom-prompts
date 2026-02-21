# Git Worktree 作成

## 概要

`~/projects/` 配下で、bare リポジトリ（例: `my-project.git`）を基点に作業用 worktree（例: `my-project-bugfix`）を作成し、最後に Cursor で起動する。

## 手順

1. ディレクトリ構造の確認

   ```sh
   ls ~/projects
   ```

   - bare リポジトリと既存 worktree の配置を把握する

2. 現在の worktree 一覧を確認

   ```sh
   git --git-dir ~/projects/my-project.git worktree list
   ```

   - 既存のパス・ブランチ重複を先に確認する

3. 分岐: 新規ブランチを作るか、既存ブランチを使うか決める

   **A. 新規ブランチを作成して worktree 作成**

   ```sh
   git --git-dir ~/projects/my-project.git worktree add -b <new-branch> ~/projects/<new-worktree-dir> <base-branch>
   ```

   - `<base-branch>` は `origin/main` 固定にしない（例: `origin/develop`, `release/2026-02`）

   **B. 既存ブランチを使って worktree 作成**

   ```sh
   # リモートにある既存ブランチをチェックアウトする場合
   git --git-dir ~/projects/my-project.git fetch origin <branch>
   git --git-dir ~/projects/my-project.git worktree add --track -b <branch> ~/projects/<new-worktree-dir> origin/<branch>

   # ローカルに既にある既存ブランチを使う場合
   git --git-dir ~/projects/my-project.git worktree add ~/projects/<new-worktree-dir> <branch>
   ```

4. 作成結果を再確認

   ```sh
   git --git-dir ~/projects/my-project.git worktree list
   ```

5. 重要な変更のときだけ worktree をロック（任意）

   ```sh
   # 誤削除を避けたい作業（大規模変更、長期検証、リリース直前）だけ実施
   git --git-dir ~/projects/my-project.git worktree lock --reason "<reason>" ~/projects/<new-worktree-dir>

   # 作業再開や削除前に解除
   git --git-dir ~/projects/my-project.git worktree unlock ~/projects/<new-worktree-dir>
   ```

6. `.cursor` をダウンロードして配置（非追跡、任意）

   ```sh
   # リポジトリアーカイブを取得して .cursor だけ取り出す
   tmp_dir="$(mktemp -d)"
   curl -L https://github.com/lvncer/ai-configs/archive/refs/heads/main.tar.gz -o "$tmp_dir/ai-configs-main.tar.gz"
   tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"
   cp -R "$tmp_dir/ai-configs-main/.cursor" ~/projects/<new-worktree-dir>/.cursor
   rm -rf "$tmp_dir"
   ```

   - Git 管理には載せない前提（`.gitignore` に `.cursor/` を含める）
   - 念のため `git -C ~/projects/<new-worktree-dir> status --short` で `.cursor` が staged/tracked されていないことを確認する

7. Cursor で起動

   ```sh
   cursor ~/projects/<new-worktree-dir>
   ```

## 例

```sh
# develop から main_bugfix を新規作成して worktree を作る例
git --git-dir ~/projects/my-project.git worktree add -b main_bugfix ~/projects/my-project-bugfix origin/develop
cursor ~/projects/my-project-bugfix
```
