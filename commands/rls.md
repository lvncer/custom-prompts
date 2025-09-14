# Row Level Security (RLS) Implementation

## Overview

Implement Row Level Security policies for database tables to ensure proper data access control and user isolation.

## Steps

1. **RLS Policy Planning**

   - Identify tables requiring RLS
   - Define access patterns and user roles
   - Plan policy conditions and rules

2. **Policy Implementation**

   - Enable RLS on target tables
   - Create appropriate policies for each operation
   - Test policy effectiveness

3. **Verification & Testing**

   - Verify policies work as expected
   - Test with different user roles
   - Validate data isolation

## RLS Policy Templates

### Basic User Data Isolation

```sql
-- Enable RLS on table
ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

-- Policy for users to access only their own data
CREATE POLICY "users_own_data" ON [table_name]
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id);
```

### Read/Write Separation

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

### Role-Based Access

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

### Public/Private Content

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

## Common RLS Patterns

### 1. User Isolation

- Each user can only access their own records
- Most common pattern for user-specific data

### 2. Team/Organization Access

- Users can access data within their team/organization
- Requires junction tables for membership

### 3. Hierarchical Access

- Different access levels based on user roles
- Admin > Manager > User hierarchy

### 4. Time-Based Access

- Access based on date ranges or schedules
- Useful for temporary permissions

## RLS Implementation Checklist

- [ ] Tables identified for RLS implementation
- [ ] RLS enabled on target tables
- [ ] Policies created for all required operations
- [ ] User roles and permissions defined
- [ ] Policies tested with different user scenarios
- [ ] Performance impact evaluated
- [ ] Documentation updated
- [ ] Team trained on RLS patterns

## Best Practices

- **Test thoroughly**: Always test policies with different user roles
- **Performance consideration**: RLS adds overhead, monitor query performance
- **Documentation**: Document policy logic for team understanding
- **Gradual rollout**: Implement RLS incrementally, not all at once
- **Backup strategy**: Have rollback plan in case of issues

## Troubleshooting

### Policy Not Working

```sql
-- Check if RLS is enabled
SELECT schemaname, tablename, rowsecurity
FROM pg_tables
WHERE tablename = '[table_name]';

-- List existing policies
SELECT * FROM pg_policies
WHERE tablename = '[table_name]';
```

### Performance Issues

```sql
-- Analyze query performance
EXPLAIN ANALYZE SELECT * FROM [table_name];

-- Consider adding indexes for policy conditions
CREATE INDEX idx_table_user_id ON [table_name](user_id);
```
