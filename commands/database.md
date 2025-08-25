# Database Design & Management

## Overview

Database schema design and management commands following established naming conventions and best practices.

## Database Naming Conventions

### Schema Design

- Models: Singular PascalCase (`User`, `Project`)
- Fields: camelCase (`firstName`, `createdAt`)
- Primary key: `id`
- Foreign key: `[tableName]Id`
- Timestamps: `createdAt`, `updatedAt`

### Relations & Security

- 1-to-many: `@relation`
- Many-to-many: intermediate table
- Cascade deletion: `onDelete: Cascade`
- Index frequently searched fields
- Validate inputs, encrypt sensitive data

## Database Commands

### Schema Management

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

### Database Operations

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

### Backup & Restore

```bash
# Create database backup
pg_dump database_name > backup.sql

# Restore from backup
psql database_name < backup.sql

# Export specific table
pg_dump -t table_name database_name > table_backup.sql
```

## File Storage

- **SQL files**: `/public/sql/` directory
- Migrations: `prisma/migrations/`
- Schema: `prisma/schema.prisma`
- Seeds: `prisma/seed.ts`

## Database Checklist

- [ ] Schema follows naming conventions
- [ ] Relations properly defined
- [ ] Indexes added for performance
- [ ] RLS policies configured
- [ ] Migration tested locally
- [ ] Backup strategy in place
- [ ] Seed data prepared
