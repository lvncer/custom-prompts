# Test-Driven Development Cycle

## Overview
Execute TDD Red-Green-Refactor cycle for robust feature development.

## Steps
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

4. **Repeat Cycle**
   - Add next test case
   - Continue Red-Green-Refactor
   - Build functionality incrementally

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
