# コードレビュー準備

## 概要

テスト、カバレッジ検証、PR 作成を含む包括的なコードレビューを準備する。

## 手順

1. **レビュー前テスト**
   - すべてのユニットテストを実行
   - 統合テストを実行
   - Playwright で E2E テストを実行

2. **コード品質チェック**
   - テストカバレッジを検証（80% 以上の目標）
   - リンティングとフォーマットを実行
   - セキュリティの脆弱性をチェック

3. **ドキュメントレビュー**
   - 必要に応じて README を更新
   - コードコメントを追加/更新
   - API ドキュメントを更新

4. **PR 準備**
   - 説明的な PR タイトルを作成
   - 包括的な PR 説明を記述
   - 関連する Issue にリンク
   - 適切なラベルを追加

## レビューチェックリスト

- [ ] すべてのテストが通過している
- [ ] テストカバレッジが 80% 以上
- [ ] リンティング/フォーマットがクリーン
- [ ] セキュリティチェックが通過している
- [ ] ドキュメントが更新されている
- [ ] 適切な説明で PR が作成されている
- [ ] 関連する Issue がリンクされている
- [ ] レビュアーが割り当てられている

## PR 説明テンプレート

```markdown
## Summary
[Brief description of changes]

## Changes Made
- [Change 1]
- [Change 2]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests passing
- [ ] E2E tests verified

## Related Issues
Closes #[issue-number]

## Screenshots (if applicable)
[Add screenshots for UI changes]
```
