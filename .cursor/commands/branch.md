# ブランチと Git 操作

## 概要

確立された命名規則とコミット慣例に従ってブランチを作成および管理する。

## ブランチ作成と命名

### ブランチ形式

- Issue 作成後に作成
- 詳細な命名規則については `.github/CONTRIBUTING.md` を参照

### 手順

1. **ブランチ命名**

   - 形式: `feat/123-feature-name`
   - Issue 番号を含める
   - 説明的な機能名を使用
   - kebab-case 規則に従う

2. **ブランチ作成**

   - main/master ブランチから作成
   - 即座にリモートにプッシュ
   - 追跡を設定

3. **初期セットアップ**
   - 必要に応じて初期コミットを作成
   - Issue ステータスを in-progress に更新
   - 開発環境をセットアップ

## コミット管理

### コミットガイドライン

- **各フェーズ完了時にコミット**
- 手動コミット（推奨）
- コミットメッセージに **Issue 番号を含める**
- **簡潔な日本語メッセージ**（最大 20 文字）
- コミットメッセージ規則については `.github/COMMIT_CONVENTION.md` を参照

## ブランチコマンド

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

## ブランチ命名規則

- **feat/**: 新機能
- **fix/**: バグ修正
- **docs/**: ドキュメント更新
- **refactor/**: コードリファクタリング
- **test/**: テスト追加/更新

## ブランチチェックリスト

- [ ] ブランチ名に Issue 番号が含まれている
- [ ] 説明的な機能名が使用されている
- [ ] main/master からブランチが作成されている
- [ ] ブランチがリモートにプッシュされている
- [ ] 追跡が設定されている
- [ ] Issue ステータスが更新されている
