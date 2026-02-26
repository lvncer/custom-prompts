# Git Worktree 作成

## 概要

bare リポジトリ（例: `Project.git`）を見つけて worktree を作成する。
入力は「既存ブランチ」または「やりたいこと（+ 任意でブランチ名）」を受け取り、worktree ディレクトリ名は必ずブランチ名から自動生成する。

## 入力

- 既存ブランチを使う場合（PR レビューなど）
  - `branch: fix/556-add-favicon-control-pc`
- 新規作業の場合
  - `task: favicon 制御の追加`
  - `branch: fix/556-add-favicon-control-pc`（任意）
  - `base: origin/main`（任意。未指定時は `origin/main`）

## 手順

1. ディレクトリ構造を確認して bare リポジトリを特定

   ```sh
   ls
   ```

   - このコマンドは「複数 worktree が見えるプロジェクトルート」で実行する前提
   - bare リポジトリ名は実ディレクトリ名を使う（例: `Project.git`）

2. worktree 一覧を確認

   ```sh
   git --git-dir <bare-repo-path> worktree list
   ```

3. リモートブランチ一覧を確認し、必要時に fetch（事故防止）

   ```sh
   git --git-dir <bare-repo-path> ls-remote --heads origin
   git --git-dir <bare-repo-path> fetch --prune origin
   git --git-dir <bare-repo-path> ls-remote --heads origin
   ```

4. worktree ディレクトリ名をブランチ名から生成

   - 例: `fix/556-add-favicon-control-pc` → `fix-556-add-favicon-control-pc`

5. 分岐して worktree を作成

   **A. 既存ブランチを使う**

   ```sh
   git --git-dir <bare-repo-path> worktree add --track -b <branch> <workspace-root>/<branch-with-slash-replaced> origin/<branch>
   ```

   **B. 新規ブランチを作る**

   ```sh
   git --git-dir <bare-repo-path> worktree add -b <branch> <workspace-root>/<branch-with-slash-replaced> <base-branch>
   ```

6. 重要な変更のときだけ worktree をロック（任意）

   ```sh
   git --git-dir <bare-repo-path> worktree lock --reason "<reason>" <workspace-root>/<branch-with-slash-replaced>
   git --git-dir <bare-repo-path> worktree unlock <workspace-root>/<branch-with-slash-replaced>
   ```

7. `.cursor` は毎回 GitHub から取得（既存 worktree からコピーしない）

   ```sh
   tmp_dir="$(mktemp -d)"
   curl -L https://github.com/lvncer/ai-configs/archive/refs/heads/main.tar.gz -o "$tmp_dir/ai-configs-main.tar.gz"
   tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"
   rm -rf <workspace-root>/<branch-with-slash-replaced>/.cursor
   cp -R "$tmp_dir/ai-configs-main/.cursor" <workspace-root>/<branch-with-slash-replaced>/.cursor
   rm -rf "$tmp_dir"
   ```

   - `.cursor` は Git 管理しない前提（`.gitignore` に `.cursor/` を含める）
   - 念のため `git -C <workspace-root>/<branch-with-slash-replaced> status --short` で staged/tracked を確認する

8. Cursor で起動

   ```sh
   cursor <workspace-root>/<branch-with-slash-replaced>
   ```
