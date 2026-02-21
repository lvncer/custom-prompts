# PR 作成とマージ

## 概要

確立されたワークフローに従い、適切な説明、Issue リンク、マージプロセス管理でプルリクエストを作成する。

## PR プロセス

### 手順

1. PR 準備

   - すべての変更がコミットされていることを確認
     - 必ず GitKraken MCP を使用
     - ツール: `git_status` (directory: リポジトリパス) で確認
   - 最新の変更をリモートにプッシュ
     - ツール: `git_push` (directory: リポジトリパス)
   - 最終テストとチェックを実行

2. PR 作成

   - 必ず、以下の PR テンプレートを参照
   - まず GitKraken MCP の使用を試みる
     - ツール: `pull_request_create` (repository_name: リポジトリ名, repository_organization: 組織名, title: PR タイトル, source_branch: ソースブランチ, target_branch: ターゲットブランチ, body: PR 本文)
   - GitKraken MCP が利用できない場合は `gh` CLI を使用
     - body には PR テンプレートを使用（`--body-file` で指定）
     - **重要**: body-file として作成した Markdown ファイルは絶対にコミットせずに、PR 作成後、必ず完全に削除する。

3. PR 設定

   - 適切なラベルを追加
     - `gh` CLI を使用: `gh pr edit [pr-number] --add-label "label1,label2"`
   - 必要に応じてレビュアーをリクエスト
     - `gh` CLI を使用: `gh pr edit [pr-number] --add-reviewer @username`

## GitHub CLI (`gh`) での PR 作成

GitKraken MCP が利用できない場合、または PR 作成機能が提供されていない場合は、GitHub CLI (`gh`) を使用する。

### 基本的な PR 作成

```sh
# Create PR with description
gh pr create --title "feat: [Feature Name] (#123)" --body-file pr-description.md

# View PR status
gh pr view
```

### 詳細な作成オプション

```sh
# PR を作成してレビュアーを同時に指定
--reviewer @username

# ドラフト PR として作成
--draft

# 特定のブランチを指定
--base main \
--head feat/123-feature-name
```

### PR 作成後、テンプレートファイルを削除

```sh
rm pr-description.md
```

## PR 説明テンプレート

以下のテンプレートを Markdown ファイルとして保存し、`--body-file` オプションで指定する。

**重要**: このファイルは一時ファイルとして扱い、PR 作成後は必ず削除すること。コミットしないこと。

```md
## 概要

<!-- このプルリクエストで行った変更の概要を記述 -->

## 関連イシュー

<!-- 関連するイシューがある場合は、イシュー番号を記載 -->
<!-- 例: Closes #123, Related to #456 -->

## 変更内容

<!-- 具体的な変更内容を箇条書きで記述 -->

## 変更理由

<!-- なぜこの変更が必要なのかを説明 -->

## スクリーンショット

<!-- UI の変更がある場合は、変更前後のスクリーンショットを添付 -->

## テスト項目

<!-- テストした項目をチェックリスト形式で記述 -->

## 影響範囲

<!-- この変更による影響範囲を記述 -->

## 動作確認方法

<!-- レビュアーが変更内容を確認するための手順を記述 -->

## チェックリスト

<!-- プルリクエストを提出する前に確認すべき項目 -->

## 特記事項

<!-- レビュアーに特に確認してほしい点や注意点があれば記述 -->

## デプロイ時の注意点

<!-- デプロイ時に必要な作業や注意点があれば記述 -->
```
