# Commit Management

## Overview
Create meaningful commits at each phase completion with proper formatting and issue references.

## Steps
1. **Commit Preparation**
   - Stage only relevant files
   - Review changes with `git diff`
   - Ensure working tree is clean

2. **Commit Message Format**
   - Include issue number
   - Use conventional commit format
   - Keep messages concise (20 characters max in Japanese, descriptive in English)
   - Follow project conventions

3. **Phase-based Commits**
   - Commit at each phase completion
   - Include phase context in message
   - Reference issue number

## Commit Commands
```bash
# Review changes
git status
git diff

# Stage specific files (never use git add .)
git add path/to/file1 path/to/file2

# Commit with proper message
git commit -m "feat: implement feature component (#123)"

# Push to remote
git push origin feat/123-feature-name
```

## Commit Message Conventions
```
feat: add new feature (#123)
fix: resolve bug in component (#123)
docs: update README (#123)
test: add unit tests (#123)
refactor: improve code structure (#123)
```

## Commit Types
- **feat**: New features
- **fix**: Bug fixes
- **docs**: Documentation changes
- **test**: Test additions/updates
- **refactor**: Code refactoring
- **style**: Formatting changes
- **chore**: Maintenance tasks

## Commit Checklist
- [ ] Only relevant files staged
- [ ] Changes reviewed with git diff
- [ ] Commit message includes issue number
- [ ] Message follows conventions
- [ ] Commit represents logical unit of work
- [ ] Changes pushed to remote
