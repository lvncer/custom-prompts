# PR 作成とマージ

## 概要

確立されたワークフローに従い、適切な説明、Issue リンク、マージプロセス管理でプルリクエストを作成する。

## PR プロセス

### 手順

1. **PR 準備**

   - すべての変更がコミットされていることを確認
   - 最新の変更をリモートにプッシュ
   - 最終テストとチェックを実行

2. **PR 作成**

   - `gh` CLI を使用（推奨）
   - PR タイトル/説明に Issue 番号を含める
   - 包括的な説明を記述
   - 手動マージが必要
   - Issue を自動クローズ
   - PR テンプレートについては `.github/PULL_REQUEST_TEMPLATE/default.md` を参照

3. **PR 設定**

   - 適切なラベルを追加
   - 必要に応じてレビュアーをリクエスト
   - "Closes #123" で自動クローズを設定

4. **作成後**
   - CI チェックを監視
   - 失敗を対処
   - レビューフィードバックに対応

## マージ後

### ブランチクリーンアップ

```bash
# Delete branch (run manually after PR merge)
# Use the following command to delete manually
gh pr merge --delete-branch
```

## PR コマンド

```bash
# Create PR with description
gh pr create --title "feat: [Feature Name] (#123)" --body-file pr-description.md

# Link issue for auto-close (include in description)
echo "Closes #123" >> pr-description.md

# View PR status
gh pr view
```

## PR 説明テンプレート

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

## PR チェックリスト

- [ ] すべての変更がコミットされプッシュされている
- [ ] PR タイトルに Issue 番号が含まれている
- [ ] 包括的な説明が記述されている
- [ ] 自動クローズのために Issue がリンクされている
- [ ] 適切なラベルが追加されている
- [ ] CI チェックが通過している
- [ ] レビュー準備が整っている
