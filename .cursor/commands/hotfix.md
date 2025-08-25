# Emergency Hotfix Flow

## Overview
Handle critical production issues with immediate response and rapid deployment.

## Steps
1. **Issue Assessment**
   - Confirm severity and impact
   - Identify root cause quickly
   - Determine if hotfix is needed

2. **Hotfix Branch Creation**
   - Create hotfix branch from main/production
   - Use naming: `hotfix/critical-issue-description`
   - Set high priority labels

3. **Rapid Implementation**
   - Implement minimal fix for the issue
   - Focus on immediate resolution, not perfect solution
   - Write targeted tests for the fix

4. **Emergency Deployment**
   - Fast-track code review
   - Deploy to staging for verification
   - Deploy to production immediately after verification

5. **Post-Hotfix Actions**
   - Monitor production for stability
   - Plan proper long-term solution
   - Update documentation and runbooks

## Hotfix Commands
```bash
# Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-issue-fix

# Create high priority issue
gh issue create --title "HOTFIX: Critical Issue" --label "priority/high,bug"

# Fast deployment
npm run build
npm run test
git add . && git commit -m "hotfix: resolve critical issue"
git push origin hotfix/critical-issue-fix

# Create emergency PR
gh pr create --title "HOTFIX: Critical Issue Fix" --label "priority/high"
```

## Hotfix Checklist
- [ ] Issue severity confirmed
- [ ] Hotfix branch created from main
- [ ] Minimal fix implemented
- [ ] Targeted tests added
- [ ] Emergency PR created
- [ ] Fast-track review completed
- [ ] Production deployment verified
- [ ] Monitoring alerts checked
- [ ] Long-term solution planned
