# 環境クリーンアップ

## 概要

プロジェクトの健全性を維持するために、一時ファイル、未使用の依存関係、開発環境をクリーンアップする。

## 手順

1. **ファイルのクリーンアップ**
   - 一時ファイルとビルド成果物を削除
   - 未使用のアセットとリソースをクリーンアップ
   - 古い設定ファイルを削除

2. **依存関係のクリーンアップ**
   - 未使用の npm/yarn パッケージを削除
   - 古い依存関係を更新
   - 必要に応じて package lock ファイルをクリーンアップ

3. **コードのクリーンアップ**
   - デッドコードと未使用のインポートを削除
   - コメントアウトされたコードをクリーンアップ
   - デバッグステートメントを削除

4. **環境リセット**
   - 開発キャッシュをクリア
   - 必要に応じてローカルデータベースをリセット
   - 環境変数をクリーンアップ

## クリーンアップコマンド

```bash
# Clean build artifacts
rm -rf .next dist build

# Clean node modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Clean git untracked files (be careful!)
git clean -fd

# Clean Bun cache
bun pm cache rm

# Clean Prisma generated files
npx prisma generate
```

## クリーンアップチェックリスト

- [ ] 一時ファイルが削除されている
- [ ] ビルド成果物がクリーンアップされている
- [ ] 未使用の依存関係が削除されている
- [ ] デッドコードが削除されている
- [ ] 開発キャッシュがクリアされている
- [ ] 環境変数が検証されている
- [ ] Git ワーキングツリーがクリーン
