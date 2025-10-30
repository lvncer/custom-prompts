# コミット管理

## 概要

各フェーズ完了時に適切なフォーマットと Issue 参照を含む意味のあるコミットを作成する。

## 手順

1. **コミット準備**
   - 関連するファイルのみをステージング
   - `git diff` で変更を確認
   - ワーキングツリーがクリーンであることを確認

2. **コミットメッセージ形式**
   - Issue 番号を含める
   - コンベンショナルコミット形式を使用
   - メッセージを簡潔に保つ（日本語は最大 20 文字、英語は説明的に）
   - プロジェクトの規則に従う

3. **フェーズベースのコミット**
   - 各フェーズ完了時にコミット
   - メッセージにフェーズコンテキストを含める
   - Issue 番号を参照

## コミットコマンド

```bash
# Review changes
git status
git diff

# Stage specific files (never use git add .)
git add path/to/file1 path/to/file2

# Commit with proper message
git commit -m "feat: implement feature component (#123)"

# Push to remote
git push origin feat/123-feature-name
```

## コミットメッセージ規則

```
feat: add new feature (#123)
fix: resolve bug in component (#123)
docs: update README (#123)
test: add unit tests (#123)
refactor: improve code structure (#123)
```

## コミットタイプ

- **feat**: 新機能
- **fix**: バグ修正
- **docs**: ドキュメント変更
- **test**: テスト追加/更新
- **refactor**: コードリファクタリング
- **style**: フォーマット変更
- **chore**: メンテナンスタスク

## コミットチェックリスト

- [ ] 関連するファイルのみがステージングされている
- [ ] 変更が git diff で確認されている
- [ ] コミットメッセージに Issue 番号が含まれている
- [ ] メッセージが規則に従っている
- [ ] コミットが論理的な作業単位を表している
- [ ] 変更がリモートにプッシュされている
