# Test Driven Development

## Overview

Execute TDD Red-Green-Refactor cycle for robust feature development following established principles.

## Basic Principles

- Follow **Red-Green-Refactor** cycle
- Write tests before implementation
- Progress in small units
- Create tests for all features

## Development Cycle

1. **Red Phase - Write Failing Test**

   - Write test for new functionality
   - Ensure test fails initially
   - Verify test is testing the right thing
   - Keep test simple and focused

2. **Green Phase - Make Test Pass**

   - Write minimal code to pass test
   - Don't worry about code quality yet
   - Focus on making test pass quickly
   - Avoid over-engineering

3. **Refactor Phase - Improve Code**
   - Improve code quality
   - Remove duplication
   - Enhance readability
   - Ensure tests still pass

## Test Structure

- **Unit Tests**: Function/method level
- **Integration Tests**: Component interaction
- **E2E Tests**: User operation simulation

## Coverage & Performance

- Target: 80%+ coverage
- Core logic: aim for 100%
- Fast test execution
- Mock external dependencies

## TDD Commands

```bash
# Run tests in watch mode
npm run test:watch

# Run specific test file
npm test -- feature.test.ts

# Check test coverage
npm run test:coverage

# Run tests with verbose output
npm test -- --verbose
```

## TDD Checklist

- [ ] Test written before implementation
- [ ] Test fails initially (Red)
- [ ] Minimal code written to pass (Green)
- [ ] Code refactored for quality
- [ ] All tests still passing
- [ ] Coverage maintained/improved
- [ ] Next test case identified
