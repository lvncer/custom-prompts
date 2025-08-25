# Branch Creation & Management

## Overview
Create feature branch following naming conventions and link to GitHub issue.

## Steps
1. **Branch Naming**
   - Format: `feat/123-feature-name`
   - Include issue number
   - Use descriptive feature name
   - Follow kebab-case convention

2. **Branch Creation**
   - Create from main/master branch
   - Push to remote immediately
   - Set up tracking

3. **Initial Setup**
   - Create initial commit if needed
   - Update issue status to in-progress
   - Set up development environment

## Branch Commands
```bash
# Get current repository info
git remote -v

# Create and switch to new branch
git checkout -b feat/123-feature-name

# Push branch to remote
git push -u origin feat/123-feature-name

# Verify branch setup
git status
```

## Branch Naming Convention
- **feat/**: New features
- **fix/**: Bug fixes
- **docs/**: Documentation updates
- **refactor/**: Code refactoring
- **test/**: Test additions/updates

## Branch Checklist
- [ ] Issue number included in branch name
- [ ] Descriptive feature name used
- [ ] Branch created from main/master
- [ ] Branch pushed to remote
- [ ] Tracking set up
- [ ] Issue status updated
