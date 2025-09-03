# Test & Build Execution

## Overview

Execute comprehensive testing, building, and development tasks for robust application development and deployment preparation.

## Steps

1. **Development Environment**

   - Start development server
   - Watch file changes
   - Hot reload functionality
   - Debug configuration

2. **Code Quality Check**

   - Run linting checks
   - Apply code formatting
   - Verify code standards
   - Fix auto-fixable issues

3. **Testing Execution**

   - Run unit tests
   - Execute integration tests
   - Perform E2E testing
   - Generate coverage reports

4. **Build Verification**
   - Create production build
   - Verify build artifacts
   - Check bundle optimization
   - Validate deployment readiness

## Development Commands

```bash
# Start development server
bun run dev

# Run development with turbopack (faster)
bun run dev
```

## Code Quality Commands

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

## Testing Commands

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

## Build Commands

```bash
# Build for production
bun run build

# Start production server locally
bun run start

# Build and start (full production simulation)
bun run build && bun run start
```

## Complete Workflow Commands

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

## ⚠️ Important Notes

- **Auto-formatting**: `bun run format` should only be executed when explicitly requested
- **Code changes**: Do not run formatting or other code-modifying commands without user instruction
- **Type checking**: Always run `bunx tsc --noEmit` to verify TypeScript types before deployment

## Test Categories

- **Unit Tests**: Individual component/function testing
- **Integration Tests**: Component interaction testing
- **E2E Tests**: Complete user workflow testing
- **Build Tests**: Production build verification

## Quality Targets

- **Code Style**: Biome formatting standards
- **Linting**: Zero linting errors
- **Test Coverage**: Comprehensive testing
- **Build Success**: Clean production build

## Development Checklist

- [ ] Development server running
- [ ] Code formatted and linted
- [ ] Unit tests passing
- [ ] Integration tests passing
- [ ] E2E tests passing
- [ ] Production build successful
- [ ] No linting errors
- [ ] All dependencies resolved
- [ ] Environment variables configured
- [ ] Ready for deployment

## Troubleshooting

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
