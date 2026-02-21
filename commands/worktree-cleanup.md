# Git Worktree クリーンアップ

## 概要

使っていない worktree を安全に整理する。まず一覧確認し、不要なものを `git worktree remove` で削除し、最後に `git worktree prune --verbose` で参照を掃除する。

## 手順

1. 現在の worktree 一覧を確認

   ```sh
   git --git-dir ~/projects/my-project.git worktree list
   ```

   - active な作業ディレクトリを誤って消さないように確認する
   - `locked` の worktree は先に解除が必要

2. 不要な worktree を削除

   ```sh
   # 通常削除
   git --git-dir ~/projects/my-project.git worktree remove ~/projects/<unused-worktree-dir>
   ```

   - 変更が残っていて削除できない場合は、まずコミットまたは stash する
   - どうしても削除する場合のみ `--force` を検討する

3. lock されている場合は解除してから削除

   ```sh
   git --git-dir ~/projects/my-project.git worktree unlock ~/projects/<unused-worktree-dir>
   git --git-dir ~/projects/my-project.git worktree remove ~/projects/<unused-worktree-dir>
   ```

4. 孤立参照を prune

   ```sh
   git --git-dir ~/projects/my-project.git worktree prune --verbose
   ```

5. 最終確認

   ```sh
   git --git-dir ~/projects/my-project.git worktree list
   ```
