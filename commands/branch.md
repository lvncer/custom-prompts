# ブランチと Git 操作

## 概要

確立された命名規則とコミット慣例に従ってブランチを作成および管理する。

## 手順

1. Git の変更状況確認
   - 必ず GitKraken MCP を使用
   - ツール: `git_status` (directory: リポジトリパス)
   - 未コミットの変更がある場合は、先にコミットまたは stash する

2. ブランチ命名
   - 以下の命名規則に従う

3. ブランチ作成
   - 必ず GitKraken MCP を使用
   - ツール: `git_branch` (action: "create", branch_name: ブランチ名, directory: リポジトリパス)

4. 初期セットアップ
   - 必要に応じて初期コミットを作成
   - Issue ステータスを in-progress に更新

## ブランチ命名規則

### 基本フォーマット

```md
<type>/<description>
```

### Type 一覧

| Type     | 説明                 |
| -------- | -------------------- |
| feat     | 新機能の追加         |
| fix      | バグ修正             |
| docs     | ドキュメントの更新   |
| style    | コードスタイルの修正 |
| refactor | リファクタリング     |
| perf     | パフォーマンス改善   |
| test     | テストの追加・修正   |
| build    | ビルドシステムの変更 |
| ci       | CI 関連の変更        |
| chore    | その他の変更         |

### 命名のルール

1. 区切り文字
   - Type と説明の間: /
   - 説明の単語間: -

2. 説明部分のルール
   - 英語の小文字のみ使用
   - 単語間は - で区切る
   - 簡潔で分かりやすい説明
   - 15 文字以内を推奨
   - 必要に応じてイシュー番号を含める

### 良い例

```md
feat/add-user-authentication
fix/resolve-login-error
docs/update-api-docs
```
