# Git 同期とプッシュ解決

## 概要

リモートの変更によりプッシュが拒否された場合の一般的な git 同期の問題を解決する。git の状態を分析し、最新の変更をプルし、競合を解決して、安全にリモートにプッシュする。

## 手順

1. 状態分析

   - 現在のリポジトリの状態を確認
     - 必ず GitKraken MCP を使用
     - ツール: `git_status` (directory: リポジトリパス)
   - 未コミットの変更を特定
   - ブランチの追跡情報を確認
   - コミット履歴の確認
     - ツール: `git_log_or_diff` (action: "log", directory: リポジトリパス)

2. 同期前の準備

   - ローカルの変更を stash またはコミット
     - stash の場合: ツール: `git_stash` (directory: リポジトリパス, name: メッセージ)
     - コミットの場合: ツール: `git_add_or_commit` (action: "add", directory: リポジトリパス, files: ファイル配列) → `git_add_or_commit` (action: "commit", directory: リポジトリパス, message: コミットメッセージ)
   - リモートの変更を fetch
     - `git fetch origin` を実行
   - ローカルとリモートのブランチを比較
     - ツール: `git_log_or_diff` (action: "log", directory: リポジトリパス) で確認

3. プルとマージ解決

   - リモートから最新の変更をプル
     - `git pull origin <ブランチ名>` を実行
   - マージ競合が発生した場合は処理
   - マージの完了を確認
     - ツール: `git_status` (directory: リポジトリパス) で状態を確認

4. 競合解決 (必要な場合)

   - 競合ファイルを特定
     - ツール: `git_status` (directory: リポジトリパス) で競合ファイルを確認
   - 手動またはツールで競合を解決
   - 解決したファイルをステージング
     - ツール: `git_add_or_commit` (action: "add", directory: リポジトリパス, files: 解決したファイル配列)
   - マージコミットを完了
     - ツール: `git_add_or_commit` (action: "commit", directory: リポジトリパス, message: マージコミットメッセージ)

5. 最終プッシュ
   - すべての変更がコミットされていることを確認
     - ツール: `git_status` (directory: リポジトリパス) で確認
   - リモートリポジトリにプッシュ
     - 必ず GitKraken MCP を使用
     - ツール: `git_push` (directory: リポジトリパス)
   - 同期の成功を確認
     - ツール: `git_status` (directory: リポジトリパス) で確認
