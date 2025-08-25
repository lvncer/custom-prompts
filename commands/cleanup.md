# Environment Cleanup

## Overview
Clean up temporary files, unused dependencies, and development environment to maintain project hygiene.

## Steps
1. **File Cleanup**
   - Remove temporary files and build artifacts
   - Clean up unused assets and resources
   - Remove obsolete configuration files

2. **Dependency Cleanup**
   - Remove unused npm/yarn packages
   - Update outdated dependencies
   - Clean package lock files if needed

3. **Code Cleanup**
   - Remove dead code and unused imports
   - Clean up commented code
   - Remove debug statements

4. **Environment Reset**
   - Clear development caches
   - Reset local database if needed
   - Clean up environment variables

## Cleanup Commands
```bash
# Clean build artifacts
rm -rf .next dist build

# Clean node modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Clean git untracked files (be careful!)
git clean -fd

# Clean Bun cache
bun pm cache rm

# Clean Prisma generated files
npx prisma generate
```

## Cleanup Checklist
- [ ] Temporary files removed
- [ ] Build artifacts cleaned
- [ ] Unused dependencies removed
- [ ] Dead code eliminated
- [ ] Development caches cleared
- [ ] Environment variables verified
- [ ] Git working tree clean
