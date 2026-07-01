# Issue 作成

## 概要

確立されたワークフローパターンに従い、適切なフェーズテンプレートとラベルで GitHub Issue を作成する。
`gh` CLI を使用する。

## 手順

### 1. Issue 計画

- 明確な Issue タイトルを定義（「Issue タイトルフォーマット」に従う）

### 2. Issue 本文のテンプレート取得（優先順）

1. `.github/ISSUE_TEMPLATE.md`, `.github/ISSUE_TEMPLATE.yml`
2. `.github/issue_template.md`, `.github/issue_template.yml`
3. `.github/ISSUE_TEMPLATE/` ディレクトリ内の `.md` もしくは `yml` ファイル

いずれも見つからない場合のみ、このコマンド内の「Issue テンプレート（body）」を body として使用する。

### 3. Issue 作成

```sh
gh issue create \
  --title "[タイトル]" \
  --body-file issue-template.md \
  --assignee @me
```

**重要**: body-file として作成した Markdown ファイルはコミットせず、Issue 作成後に必ず削除する。

```sh
rm issue-template.md
```

### 4. ラベルを追加

```sh
gh issue edit [issue-number] --add-label "enhancement"
gh issue edit [issue-number] --add-label "priority/medium"
```

- **Priority**: `priority/high` / `priority/medium` / `priority/low`
- **Type**: `bug`, `documentation`, `enhancement` など

## Issue タイトルフォーマット

```
<type>: <説明>
```

| Type     | 説明               |
| -------- | ------------------ |
| feat     | 新機能の追加       |
| fix      | バグ修正           |
| docs     | ドキュメントの更新 |
| refactor | リファクタリング   |

- 日本語で記述、体言止め、50文字以内

### 良い例

```
feat: ユーザー認証機能を追加
fix: ログインエラーを修正
```

## Issue テンプレート（body）

```md
## 概要

## 現状の問題点

## 期待される結果

## 提案される解決策

## フェーズ

### Phase 1: 環境セットアップ

- [ ] ブランチ作成
- [ ] 依存関係・設定の追加・更新

### Phase 2: 実装

- [ ] （具体的なタスク）

### 最終フェーズ: テストと検証

- [ ] ビルド・テストの実行
- [ ] 動作確認

## 追加情報

## 関連リンク
```
