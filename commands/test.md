# テストとビルド実行

## 概要

堅牢なアプリケーション開発とデプロイ準備のため、包括的なテスト、ビルド、開発タスクを実行する。

## 手順

1. **開発環境**

   - 開発サーバーを起動
   - ファイル変更を監視
   - ホットリロード機能
   - デバッグ設定

2. **コード品質チェック**

   - リンティングチェックを実行
   - コードフォーマットを適用
   - コード標準を検証
   - 自動修正可能な問題を修正

3. **テスト実行**

   - ユニットテストを実行
   - 統合テストを実行
   - E2E テストを実行
   - カバレッジレポートを生成

4. **ビルド検証**
   - プロダクションビルドを作成
   - ビルド成果物を検証
   - バンドル最適化を確認
   - デプロイ準備状況を検証

## 開発コマンド

```bash
# Start development server
bun run dev

# Run development with turbopack (faster)
bun run dev
```

## コード品質コマンド

```bash
# Check TypeScript types (no compilation)
bunx tsc --noEmit

# Check code quality and linting
bun run lint

# Format code automatically (⚠️ Only run when explicitly requested)
bun run format

# Run type check and lint together
bunx tsc --noEmit && bun run lint
```

## テストコマンド

```bash
# Run unit tests only
bun run test

# Run integration tests
bun run test:integration

# Run E2E tests
bun run test:e2e

# Run all tests (unit + integration + e2e)
bun run test:all

# Run tests in specific directory
bun test src/tests/unit/AuthButton.test.tsx

# Run tests with verbose output
bun test --verbose src/tests/
```

## ビルドコマンド

```bash
# Build for production
bun run build

# Start production server locally
bun run start

# Build and start (full production simulation)
bun run build && bun run start
```

## 完全なワークフローコマンド

```bash
# Development verification (recommended for regular checks)
bunx tsc --noEmit && bun run lint && bun run test:all

# Pre-deployment verification (without auto-formatting)
bunx tsc --noEmit && bun run lint && bun run test:all && bun run build

# Quick development check
bunx tsc --noEmit && bun run lint && bun run test

# Complete CI/CD simulation
bunx tsc --noEmit && bun run lint && bun run test:all && bun run build && bun run start
```

## ⚠️ 重要な注意事項

- **自動フォーマット**: `bun run format` は明示的に要求された場合のみ実行する
- **コード変更**: ユーザーの指示なしにフォーマットやその他のコード変更コマンドを実行しない
- **型チェック**: デプロイ前に常に `bunx tsc --noEmit` を実行して TypeScript の型を検証する

## テストカテゴリ

- **Unit Tests**: 個別のコンポーネント/関数のテスト
- **Integration Tests**: コンポーネント相互作用のテスト
- **E2E Tests**: 完全なユーザーワークフローのテスト
- **Build Tests**: プロダクションビルドの検証

## 品質目標

- **コードスタイル**: Biome フォーマット標準
- **リンティング**: リンティングエラーなし
- **テストカバレッジ**: 包括的なテスト
- **ビルド成功**: クリーンなプロダクションビルド

## 開発チェックリスト

- [ ] 開発サーバーが動作している
- [ ] コードがフォーマットされリントされている
- [ ] ユニットテストが通過している
- [ ] 統合テストが通過している
- [ ] E2E テストが通過している
- [ ] プロダクションビルドが成功している
- [ ] リンティングエラーがない
- [ ] すべての依存関係が解決されている
- [ ] 環境変数が設定されている
- [ ] デプロイ準備が整っている

## トラブルシューティング

```bash
# Clear Next.js cache
rm -rf .next

# Clear node_modules and reinstall
rm -rf node_modules && bun install

# Clear Bun cache
bun clean

# Reset development environment
rm -rf .next node_modules && bun install && bun run dev

# Full clean and type check
rm -rf .next node_modules && bun install && bunx tsc --noEmit
```
