# プロンプトログ管理

## 概要

プロジェクト履歴とナレッジシェアリングのために実装ログを保存する。

## 手順

1. **ログエントリの作成**

   - `.prompts/` ディレクトリにファイルを作成
   - フォーマット: `yyyy-mm-dd_feature-name.md` を使用
   - 実装詳細と決定事項を含める

2. **実装の文書化**

   - 重要な技術的決定を記録
   - コードスニペットと例を含める
   - 課題と解決策を記録

3. **ナレッジシェアリング**
   - 学んだ教訓を文書化
   - 発見したベストプラクティスを含める
   - 今後の改善領域を記録

## ログコンテンツテンプレート

```markdown
# Feature Implementation Log - [Feature Name]

## Date

[YYYY-MM-DD]

## Overview

[Brief description of what was implemented]

## Technical Decisions

- [Decision 1 and rationale]
- [Decision 2 and rationale]

## Implementation Details

[Key code changes and architecture decisions]

## Challenges & Solutions

[Problems encountered and how they were solved]

## Lessons Learned

[What was learned during implementation]

## Future Improvements

[Areas for potential enhancement]
```

## ログチェックリスト

- [ ] `.prompts/` ディレクトリにログファイルが作成されている
- [ ] 実装詳細が文書化されている
- [ ] 技術的決定が記録されている
- [ ] 課題と解決策が記録されている
- [ ] 学んだ教訓が記録されている
