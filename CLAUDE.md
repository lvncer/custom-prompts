# Claude Code Rules

## Global Rules

- **Always respond in Japanese**
- **No changes without explicit instructions** (UI/UX, tech stack)
- **Always confirm unclear points**
- **Execute step by step**
- **Check for duplicate functionality** (existing features, APIs, common processes)

### Execution Flow

1. **Analysis**: Task summary, rule confir$$mation, requirement identification
2. **Execution**: Follow directory structure & naming conventions
3. **Quality Control**: Error handling (isolation → solution → verification → analysis)
4. **Report**: Final confirmation & reporting

## Prompt Logs

**MANDATORY**: After implementation completion, save implementation logs to `.prompts/` directory in `yyyy-mm-dd_feature-name.md` format.

## Notifications

**REQUIRED**: Send notifications for ALL task completions without exception. Notification content must be appropriately described according to the executed task.

## Workflows

### 1. Preparation

GitHub Username: lvncer

### 2. Issue Management

#### Issue Creation

Use GitHub MCP (recommended)

#### Phase Template

```md
## Implementation Phases

- [ ] **Phase 1: Environment Setup**

  - [ ] Branch creation (`feat/123-feature`)
  - [ ] Dependencies addition

- [ ] **Phase 2: [Specific Work Content]**

  - [ ] Detailed task 1
  - [ ] Detailed task 2

- [ ] **Phase N: Testing & Verification**
  - [ ] Build test
  - [ ] Function test

## Completion Criteria

- [ ] All phases complete
- [ ] Tests passing
- [ ] Review complete
```

#### Label Classification

- **Priority**: `priority/high|medium|low`
- **Type**: `enhancement|bug|documentation`
- **Status**: `in-progress|review-needed|blocked`

### 3. Branch & Git Operations

#### Branch Creation & Naming

- Format: `feat/123-feature-name`
- Create after issue creation

#### Commit Management

- **Commit at each phase completion**
- Manual commits (recommended)
- **Include issue number** in commit messages
- **Concise Japanese messages** (20 characters max)

### 4. PR Creation & Merge

#### PR Process

- Use GitHub MCP (recommended)
- Include issue number in PR title/description
- Manual merge required
- Auto-close issues

#### Post-Merge

```bash
git branch -d feat/123-feature
git push origin --delete feat/123-feature
```

## Tech Stack

### Frontend Core

- **React** + **Next.js** (Server Components)
- **TypeScript** + **Bun** (runtime)

### UI Framework

- **Shadcn/ui** + **Tailwind CSS**
- **Radix UI** + **Lucide React** (icons)

### Authentication & Backend

- **Clerk** (auth)
- **Prisma** (ORM) + **Supabase** (BaaS)

### Testing

- **Vitest** (unit/integration)
- **React Testing Library** (components)
- **Playwright** (E2E)
- **MSW** (API mocking)

### Others

- **Server Actions** + **Zod** (forms/validation)
- **date-fns** (date handling)
- **Stripe** (payments) + **Vercel** (deployment)

## Directory Structure

```sh
src/
├── app/           # Routing & pages
├── components/
│   ├── ui/        # ShadCn UI components
│   └── layouts/
├── hooks/         # Custom hooks
├── types/
└── lib/           # Utilities
    ├── constants/
    └── utils/
```

### File Naming Conventions

- Pages: `page.tsx`
- Layouts: `layout.tsx`
- Loading: `loading.tsx`
- Errors: `error.tsx`
- APIs: `route.ts`

### Component Design

- **Server Components** (default): Data fetching, SEO
- **Client Components** (when needed): Browser APIs, event listeners, hooks

### API Design

- **No GET APIs** → Use Server Components for data fetching
- **POST/PATCH/PUT/DELETE only**
- Prefer Server Actions

## Test Driven Development

### Basic Principles

- Follow **Red-Green-Refactor** cycle
- Write tests before implementation
- Progress in small units
- Create tests for all features

### Development Cycle

1. **Red**: Write failing tests
2. **Green**: Write minimum code to pass
3. **Refactor**: Improve code quality

### Test Structure

- **Unit Tests**: Function/method level
- **Integration Tests**: Component interaction
- **E2E Tests**: User operation simulation

### Coverage & Performance

- Target: 80%+ coverage
- Core logic: aim for 100%
- Fast test execution
- Mock external dependencies

## UI/UX Guidelines

### Critical Constraints

- **No existing UI changes without approval**
- Layout/color/font/spacing changes require approval
- Minimal customization
- Reuse existing components

### Design System

- Mobile-first responsive
- WAI-ARIA compliance
- Keyboard navigation support
- Proper contrast ratios

### Styling & Dark Mode

- Custom classes with `@layer`
- `kebab-case` naming
- System-synchronized dark mode

## Database Design

### Database Naming Conventions

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

### File Storage

- **SQL files**: `/public/sql/` directory
- Migrations: `prisma/migrations/`

## Essential Checklist

### Start

- [ ] GitHub username obtained
- [ ] Issue created with phases
- [ ] Branch created (with issue number)
- [ ] Appropriate labels set

### Development

- [ ] Commit at each phase completion
- [ ] Issue number in commit messages
- [ ] Regular pushes
- [ ] Issue checkbox updates

### Completion

- [ ] All phases complete
- [ ] Final tests executed
- [ ] PR created (with issue number)
- [ ] Manual merge executed
- [ ] Issue auto-closed confirmed
- [ ] Branch deleted
- [ ] **Prompt log saved to `.prompts/`**
