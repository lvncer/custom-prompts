# データベース設計と管理

## 概要

確立された命名規則とベストプラクティスに従ったデータベーススキーマ設計と管理コマンド。

## データベース命名規則

### スキーマ設計

- モデル: 単数形 PascalCase (`User`, `Project`)
- フィールド: camelCase (`firstName`, `createdAt`)
- プライマリキー: `id`
- 外部キー: `[tableName]Id`
- タイムスタンプ: `createdAt`, `updatedAt`

### リレーションとセキュリティ

- 1対多: `@relation`
- 多対多: 中間テーブル
- カスケード削除: `onDelete: Cascade`
- 頻繁に検索されるフィールドにインデックス
- 入力を検証し、機密データを暗号化

## データベースコマンド

### スキーマ管理

```bash
# Generate Prisma client
npx prisma generate

# Create migration
npx prisma migrate dev --name feature-name

# Deploy migrations to production
npx prisma migrate deploy

# Reset database (development only)
npx prisma migrate reset
```

### データベース操作

```bash
# Open Prisma Studio
npx prisma studio

# Seed database
npx prisma db seed

# Check migration status
npx prisma migrate status

# Format schema file
npx prisma format
```

### バックアップと復元

```bash
# Create database backup
pg_dump database_name > backup.sql

# Restore from backup
psql database_name < backup.sql

# Export specific table
pg_dump -t table_name database_name > table_backup.sql
```

## ファイルストレージ

- **SQL ファイル**: `/public/sql/` ディレクトリ
- マイグレーション: `prisma/migrations/`
- スキーマ: `prisma/schema.prisma`
- シード: `prisma/seed.ts`

## データベースチェックリスト

- [ ] スキーマが命名規則に従っている
- [ ] リレーションが適切に定義されている
- [ ] パフォーマンスのためにインデックスが追加されている
- [ ] RLS ポリシーが設定されている
- [ ] マイグレーションがローカルでテストされている
- [ ] バックアップ戦略が確立されている
- [ ] シードデータが準備されている
