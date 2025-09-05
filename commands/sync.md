# Git Sync & Push Resolution

## Overview

Resolve common git sync issues when push is rejected due to remote changes. Analyze git status, pull latest changes, resolve conflicts, and safely push to remote.

## Steps

1. **Status Analysis**
   - Check current repository status
   - Identify uncommitted changes
   - Review branch tracking information

2. **Pre-sync Preparation**
   - Stash or commit local changes
   - Fetch remote changes
   - Compare local and remote branches

3. **Pull & Merge Resolution**
   - Pull latest changes from remote
   - Handle merge conflicts if they occur
   - Verify merge completion

4. **Conflict Resolution** (if needed)
   - Identify conflicted files
   - Resolve conflicts manually or with tools
   - Stage resolved files
   - Complete merge commit

5. **Final Push**
   - Verify all changes are committed
   - Push to remote repository
   - Confirm successful sync

## Sync Commands

```bash
# 1. Check current status
git status
git log --oneline -5
git remote -v

# 2. Save local work
git add .
git commit -m "WIP: save current work before sync"
# OR stash if not ready to commit
git stash push -m "WIP before sync"

# 3. Fetch and compare
git fetch origin
git status
git log --oneline origin/main..HEAD  # local commits
git log --oneline HEAD..origin/main  # remote commits

# 4. Pull and merge
git pull origin main
# If conflicts occur, resolve them

# 5. Handle conflicts (if any)
git status  # shows conflicted files
# Edit files to resolve conflicts
git add path/to/resolved/file
git commit -m "resolve merge conflicts"

# 6. Push changes
git push origin main
```

## Automated Sync Flow

```bash
# Quick sync command sequence
git status && \
git add . && \
git commit -m "sync: prepare local changes" && \
git fetch origin && \
git pull origin $(git branch --show-current) && \
git push origin $(git branch --show-current)
```

## Common Error Solutions

### "Updates were rejected"

```bash
# Fetch latest remote info
git fetch origin

# Pull with rebase for cleaner history
git pull --rebase origin main

# If conflicts, resolve and continue
git rebase --continue

# Push changes
git push origin main
```

### "Divergent branches"

```bash
# Option 1: Merge strategy (default)
git pull origin main

# Option 2: Rebase strategy (cleaner history)
git pull --rebase origin main

# Option 3: Force pull (destructive - use with caution)
git fetch origin
git reset --hard origin/main
```

## Sync Strategies

### Safe Merge Strategy

- Preserves both local and remote history
- Creates merge commits
- Safer for collaborative work

### Rebase Strategy

- Creates linear history
- Moves local commits on top of remote
- Cleaner but can be complex with conflicts

### Branch Protection

```bash
# Create backup branch before risky operations
git checkout -b backup-$(date +%Y%m%d-%H%M%S)
git checkout main
# Proceed with sync operations
```

## Sync Checklist

- [ ] Local changes committed or stashed
- [ ] Remote changes fetched
- [ ] Branch comparison reviewed
- [ ] Pull completed successfully
- [ ] Conflicts resolved (if any)
- [ ] All tests passing
- [ ] Push completed successfully
- [ ] Remote branch updated
- [ ] Local and remote in sync
