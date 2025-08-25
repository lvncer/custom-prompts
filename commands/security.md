# Security Checks & RLS Setup

## Overview
Perform comprehensive security checks and set up Row Level Security policies for data protection.

## Steps
1. **Security Audit**
   - Check for exposed secrets or API keys
   - Verify input validation and sanitization
   - Review authentication and authorization

2. **Database Security**
   - Implement Row Level Security (RLS) policies
   - Verify proper access controls
   - Check for SQL injection vulnerabilities

3. **Frontend Security**
   - Validate client-side security measures
   - Check for XSS vulnerabilities
   - Verify CSRF protection

4. **Infrastructure Security**
   - Review environment variable handling
   - Check HTTPS configuration
   - Verify secure headers

## RLS Policy Template
```sql
-- Enable RLS on table
ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

-- Create policy for authenticated users
CREATE POLICY "[policy_name]" ON [table_name]
  FOR [SELECT|INSERT|UPDATE|DELETE]
  TO authenticated
  USING ([condition]);

-- Example: Users can only access their own data
CREATE POLICY "users_own_data" ON profiles
  FOR ALL
  TO authenticated
  USING (auth.uid() = user_id);
```

## Security Checklist
- [ ] No secrets exposed in code
- [ ] Input validation implemented
- [ ] Authentication verified
- [ ] RLS policies created
- [ ] Access controls tested
- [ ] Security headers configured
- [ ] HTTPS enforced
- [ ] Vulnerability scan completed
