# Git Worktree 作成

## 概要

bare リポジトリ（例: `Project.git`）を見つけて worktree を作成する。
入力は「既存ブランチ」または「やりたいこと（+ 任意でブランチ名）」を受け取り、worktree ディレクトリ名は必ずブランチ名から自動生成する。
実行時は **GitKraken MCP を最優先** で使い、未対応操作のみ `gh` をフォールバックで使う。

## 入力

- 既存ブランチを使う場合（PR レビューなど）
  - `branch: fix/556-add-favicon-control-pc`
- 新規作業の場合
  - `task: favicon 制御の追加`
  - `branch: fix/556-add-favicon-control-pc`（任意）
  - `base: origin/main`（任意。未指定時は `origin/main`）

## 手順

1. ディレクトリ構造を確認して bare リポジトリを特定
   - 優先ツール: `gitkraken_workspace_list`
   - 補助: bare リポジトリ名の最終確認に `ls` を使う

   ```sh
   ls
   ```

   - このコマンドは「複数 worktree が見えるプロジェクトルート」で実行する前提
   - bare リポジトリ名は実ディレクトリ名を使う（例: `Project.git`）

2. worktree 一覧を確認
   - 優先ツール: `git_worktree`（list）
   - 補助: 出力不足時のみ git コマンドを使う

   ```sh
   git --git-dir list < bare-repo-path > worktree
   ```

3. bare リポジトリで最新を取得し、ローカル参照を先に同期（必須）
   - 優先ツール: `git_log_or_diff`（履歴確認）, `git_branch`（参照確認）
   - 実同期は git コマンドで実行する（`fetch --prune` / `update-ref`）

   ```sh
   git --git-dir --heads origin < bare-repo-path > ls-remote
   git --git-dir --prune origin < bare-repo-path > fetch
   git --git-dir --heads origin < bare-repo-path > ls-remote
   ```

   - `non-fast-forward` で履歴が崩れる事故を防ぐため、worktree 作成前に必ず実行する
   - 既存ブランチを使う場合は、必要に応じて bare 側のローカルブランチ参照も `origin/<branch>` に合わせる

   ```sh
   git --git-dir <bare-repo-path> update-ref refs/heads/<branch> refs/remotes/origin/<branch>
   ```

4. worktree ディレクトリ名をブランチ名から生成
   - 例: `fix/556-add-favicon-control-pc` → `fix-556-add-favicon-control-pc`

5. 分岐して worktree を作成
   - 優先ツール: `git_worktree`（add）, `git_branch`（必要時）

   **A. 既存ブランチを使う**

   ```sh
   git --git-dir <bare-repo-path> worktree add --track -b <branch> <workspace-root>/<branch-with-slash-replaced> origin/<branch>
   ```

   - 既存ブランチがすでに bare 側にある場合は `-b` を付けずに追加する

   ```sh
   git --git-dir <bare-repo-path> worktree add --track <workspace-root>/<branch-with-slash-replaced> origin/<branch>
   ```

   **B. 新規ブランチを作る**

   ```sh
   git --git-dir <bare-repo-path> worktree add -b <branch> <workspace-root>/<branch-with-slash-replaced> <base-branch>
   ```

6. 重要な変更のときだけ worktree をロック（任意）
   - 優先ツール: `git_worktree`（lock / unlock）

   ```sh
   git --git-dir <bare-repo-path> worktree lock --reason "<reason>" <workspace-root>/<branch-with-slash-replaced>
   git --git-dir <bare-repo-path> worktree unlock <workspace-root>/<branch-with-slash-replaced>
   ```

7. `.cursor` は毎回 GitHub から取得（既存 worktree からコピーしない）
   - 反映後の確認は `git_status` を優先（不足時のみ `git status`）

   ```sh
   tmp_dir="$(mktemp -d)"
   curl -L https://github.com/lvncer/ai-configs/archive/refs/heads/main.tar.gz -o "$tmp_dir/ai-configs-main.tar.gz"
   tar -xzf "$tmp_dir/ai-configs-main.tar.gz" -C "$tmp_dir"
   rm -rf < workspace-root > / < branch-with-slash-replaced > /.cursor
   cp -R "$tmp_dir/ai-configs-main/.cursor" < workspace-root > / < branch-with-slash-replaced > /.cursor
   rm -rf "$tmp_dir"
   ```

   - `.cursor` は Git 管理しない前提（`.gitignore` に `.cursor/` を含める）
   - 念のため `git -C <workspace-root>/<branch-with-slash-replaced> status --short` で staged/tracked を確認する

8. Cursor で起動

   ```sh
   cursor <workspace-root>/<branch-with-slash-replaced>
   ```
