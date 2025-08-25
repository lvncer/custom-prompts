# Issue Creation

## Overview

Create GitHub issue with proper phase template and labels following established workflow patterns.

## Preparation

### GitHub CLI: Retrieve username and repository name

#### GitHub username

```bash
git config user.name
```

#### Repository name of the current directory

```bash
git remote -v
```

## Steps

1. **Issue Planning**

   - Define clear issue title
   - Write comprehensive description
   - Identify implementation phases

2. **Phase Template Setup**

   - Use standard phase template structure
   - Define environment setup phase
   - Plan specific work content phases
   - Include testing & verification phase

3. **Label Assignment**

   - Set appropriate priority (high/medium/low)
   - Assign type (enhancement/bug/documentation)
   - Add status labels as needed

4. **Issue Creation**
   - Use `gh` CLI for creation
   - Reference issue templates if available
   - Link related issues or epics

## Issue Template

```markdown
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

### Label Classification

- **Priority**: `priority/high|medium|low`
- **Type**: `enhancement|bug|documentation`
- **Status**: `in-progress|review-needed|blocked`

## Issue Creation Commands

```bash
# Create issue with template
gh issue create --title "Feature: [Feature Name]" --body-file issue-template.md

# Add labels
gh issue edit [issue-number] --add-label "enhancement,priority/medium"
```

## Issue Checklist

- [ ] Clear title defined
- [ ] Phase template included
- [ ] Appropriate labels assigned
- [ ] Issue created successfully
- [ ] Issue number noted for branch creation
