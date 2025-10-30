# Issue 作成

## 概要

確立されたワークフローパターンに従い、適切なフェーズテンプレートとラベルで GitHub Issue を作成する。

## 準備

### GitHub CLI: ユーザー名とリポジトリ名を取得

#### GitHub ユーザー名

```bash
git config user.name
```

#### 現在のディレクトリのリポジトリ名

```bash
git remote -v
```

## 手順

1. **Issue 計画**

   - 明確な Issue タイトルを定義
   - 包括的な説明を記述
   - 実装フェーズを特定

2. **フェーズテンプレート設定**

   - 標準的なフェーズテンプレート構造を使用
   - 環境セットアップフェーズを定義
   - 特定の作業内容フェーズを計画
   - テストと検証フェーズを含める

3. **ラベル割り当て**

   - 適切な優先度を設定（high/medium/low）
   - タイプを割り当てる（enhancement/bug/documentation）
   - 必要に応じてステータスラベルを追加

4. **Issue 作成**
   - 作成には `gh` CLI を使用
   - 利用可能な場合、Issue テンプレートを参照
   - 関連する Issue や Epic にリンク

## Issue テンプレート

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

### ラベル分類

- **Priority**: `priority/high|medium|low`
- **Type**: `enhancement|bug|documentation`
- **Status**: `in-progress|review-needed|blocked`

## Issue 作成コマンド

```bash
# Create issue with template
gh issue create --title "Feature: [Feature Name]" --body-file issue-template.md

# Add labels
gh issue edit [issue-number] --add-label "enhancement,priority/medium"
```

## Issue チェックリスト

- [ ] 明確なタイトルが定義されている
- [ ] フェーズテンプレートが含まれている
- [ ] 適切なラベルが割り当てられている
- [ ] Issue が正常に作成されている
- [ ] ブランチ作成のために Issue 番号が記録されている
