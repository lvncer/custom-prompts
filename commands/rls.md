# Row Level Security (RLS) 実装

## 概要

適切なデータアクセス制御とユーザー分離を確保するため、データベーステーブルに Row Level Security ポリシーを実装する。

## 手順

1. **RLS ポリシー計画**

   - RLS が必要なテーブルを特定
   - アクセスパターンとユーザーロールを定義
   - ポリシー条件とルールを計画

2. **ポリシー実装**

   - 対象テーブルで RLS を有効化
   - 各操作に対する適切なポリシーを作成
   - ポリシーの効果をテスト

3. **検証とテスト**

   - ポリシーが期待通りに動作することを確認
   - 異なるユーザーロールでテスト
   - データ分離を検証

## RLS ポリシーテンプレート

### 基本ユーザーデータ分離

```sql
-- Enable RLS on table
ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

-- Policy for users to access only their own data
CREATE POLICY "users_own_data" ON [table_name]
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id);
```

### 読み取り/書き込み分離

```sql
-- Read policy
CREATE POLICY "read_own_data" ON [table_name]
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Write policy
CREATE POLICY "write_own_data" ON [table_name]
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Update policy
CREATE POLICY "update_own_data" ON [table_name]
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
```

### ロールベースアクセス

```sql
-- Admin access policy
CREATE POLICY "admin_access" ON [table_name]
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM user_roles
      WHERE user_id = auth.uid()
      AND role = 'admin'
    )
  );

-- Team member access
CREATE POLICY "team_access" ON [table_name]
  FOR SELECT
  TO authenticated
  USING (
    team_id IN (
      SELECT team_id FROM team_members
      WHERE user_id = auth.uid()
    )
  );
```

### パブリック/プライベートコンテンツ

```sql
-- Public content access
CREATE POLICY "public_content" ON [table_name]
  FOR SELECT
  TO authenticated
  USING (is_public = true OR user_id = auth.uid());

-- Private content access
CREATE POLICY "private_content" ON [table_name]
  FOR ALL
  TO authenticated
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());
```

## 一般的な RLS パターン

### 1. ユーザー分離

- 各ユーザーが自分のレコードにのみアクセス可能
- ユーザー固有のデータの最も一般的なパターン

### 2. チーム/組織アクセス

- ユーザーがチーム/組織内のデータにアクセス可能
- メンバーシップには結合テーブルが必要

### 3. 階層型アクセス

- ユーザーロールに基づく異なるアクセスレベル
- Admin > Manager > User の階層

### 4. 時間ベースアクセス

- 日付範囲やスケジュールに基づくアクセス
- 一時的な権限に有用

## RLS 実装チェックリスト

- [ ] RLS 実装が必要なテーブルが特定されている
- [ ] 対象テーブルで RLS が有効になっている
- [ ] 必要なすべての操作に対してポリシーが作成されている
- [ ] ユーザーロールと権限が定義されている
- [ ] 異なるユーザーシナリオでポリシーがテストされている
- [ ] パフォーマンスへの影響が評価されている
- [ ] ドキュメントが更新されている
- [ ] チームが RLS パターンについて教育を受けている

## ベストプラクティス

- **徹底的にテストする**: 常に異なるユーザーロールでポリシーをテストする
- **パフォーマンスを考慮**: RLS はオーバーヘッドを追加するため、クエリパフォーマンスを監視する
- **ドキュメント**: チームの理解のためにポリシーロジックを文書化する
- **段階的な展開**: 一度に全部ではなく、段階的に RLS を実装する
- **バックアップ戦略**: 問題が発生した場合のロールバック計画を準備する

## トラブルシューティング

### ポリシーが動作しない

```sql
-- Check if RLS is enabled
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE tablename = '[table_name]';

-- List existing policies
SELECT * FROM pg_policies
WHERE tablename = '[table_name]';
```

### パフォーマンスの問題

```sql
-- Analyze query performance
EXPLAIN ANALYZE SELECT * FROM [table_name];

-- Consider adding indexes for policy conditions
CREATE INDEX idx_table_user_id ON [table_name](user_id);
```
