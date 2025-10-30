# Git 同期とプッシュ解決

## 概要

リモートの変更によりプッシュが拒否された場合の一般的な git 同期の問題を解決する。git の状態を分析し、最新の変更をプルし、競合を解決して、安全にリモートにプッシュする。

## 手順

1. **状態分析**
   - 現在のリポジトリの状態を確認
   - 未コミットの変更を特定
   - ブランチの追跡情報を確認

2. **同期前の準備**
   - ローカルの変更をstashまたはコミット
   - リモートの変更をfetch
   - ローカルとリモートのブランチを比較

3. **プルとマージ解決**
   - リモートから最新の変更をプル
   - マージ競合が発生した場合は処理
   - マージの完了を確認

4. **競合解決** (必要な場合)
   - 競合ファイルを特定
   - 手動またはツールで競合を解決
   - 解決したファイルをステージング
   - マージコミットを完了

5. **最終プッシュ**
   - すべての変更がコミットされていることを確認
   - リモートリポジトリにプッシュ
   - 同期の成功を確認

## 同期コマンド

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

## 自動同期フロー

```bash
# Quick sync command sequence
git status && \
git add . && \
git commit -m "sync: prepare local changes" && \
git fetch origin && \
git pull origin $(git branch --show-current) && \
git push origin $(git branch --show-current)
```

## 一般的なエラー解決

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

## 同期戦略

### Safe Merge Strategy

- ローカルとリモートの履歴の両方を保持
- マージコミットを作成
- 共同作業により安全

### Rebase Strategy

- 線形の履歴を作成
- ローカルコミットをリモートの上に移動
- よりクリーンだが、競合があると複雑になる可能性がある

### Branch Protection

```bash
# Create backup branch before risky operations
git checkout -b backup-$(date +%Y%m%d-%H%M%S)
git checkout main
# Proceed with sync operations
```

## 同期チェックリスト

- [ ] ローカルの変更がコミットまたはstashされている
- [ ] リモートの変更がfetchされている
- [ ] ブランチの比較が確認されている
- [ ] プルが正常に完了している
- [ ] 競合が解決されている (発生した場合)
- [ ] すべてのテストが通過している
- [ ] プッシュが正常に完了している
- [ ] リモートブランチが更新されている
- [ ] ローカルとリモートが同期している
