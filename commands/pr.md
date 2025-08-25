# Pull Request Creation

## Overview
Create pull request with proper description, issue linking, and auto-close configuration.

## Steps
1. **Pre-PR Preparation**
   - Ensure all changes committed
   - Push latest changes to remote
   - Run final tests and checks

2. **PR Creation**
   - Use `gh` CLI for creation
   - Include issue number in title
   - Write comprehensive description
   - Link related issues for auto-close

3. **PR Configuration**
   - Add appropriate labels
   - Request reviewers if needed
   - Set up auto-close with "Closes #123"

4. **Post-Creation**
   - Monitor CI checks
   - Address any failures
   - Respond to review feedback

## PR Commands
```bash
# Create PR with description
gh pr create --title "feat: [Feature Name] (#123)" --body-file pr-description.md

# Link issue for auto-close (include in description)
echo "Closes #123" >> pr-description.md

# View PR status
gh pr view
```

## PR Description Template
```markdown
## Summary
[Brief description of changes]

## Changes Made
- [Change 1]
- [Change 2]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests passing
- [ ] Manual testing completed

## Related Issues
Closes #[issue-number]

## Review Checklist
- [ ] Code follows project conventions
- [ ] Tests cover new functionality
- [ ] Documentation updated
- [ ] No breaking changes
```

## PR Checklist
- [ ] All changes committed and pushed
- [ ] PR title includes issue number
- [ ] Comprehensive description written
- [ ] Issue linked for auto-close
- [ ] Appropriate labels added
- [ ] CI checks passing
- [ ] Ready for review
