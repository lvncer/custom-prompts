# Custom Prompts

[![CC BY 4.0][cc-by-shield]][cc-by]

Custom Prompts は、開発効率と品質を向上させるための独自のプロンプト集です。

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

## 📋 概要

このプロジェクトは、開発において以下を実現するためのルール集です：

- **一貫性のある開発**: 統一されたコーディング規約とベストプラクティス
- **効率的な作業**: 自動化されたワークフローとテンプレート
- **品質管理**: エラー防止と保守性の向上
- **知識共有**: チーム内での技術的決定の透明性

## 対応AI

- Cursor
  - [Cursor Rules](./.cursor/rules/index.mdc)
  - [Cursor Slash Commands Instructions](./.cursor/slash-commands.md)
  - [Cursor Custom Slash Commands](./.cursor/commands/)
  - [Cursor MCP](./.cursor/mcp.json)
- Claude Code
  - [Claude Code Rules](./CLAUDE.md)
  - [Claude Code MCP](./mcp.json)
  - [Claude Code Settings](./.claude/settings.local.json)
- Windsurf
  - [Windsurf Rules](./.windsurf/rules/index.md)

## 🗂️ ルール構成

### 🔄 常時適用ルール

- [グローバルルール](#global-rules) - 基本的な開発原則と実行フロー
- [ワークフロー](#workflows) - Issue 管理・Git 操作・PR 作成の統合フロー
- [技術スタック](#tech-stack) - 使用技術とバージョン管理
- [MCP](#mcp) - 使用する MCP のツールと使用タイミング、簡単な説明を含む
- [ディレクトリ構造](#directory-structure) - プロジェクト構造とファイル命名規則
- [テスト駆動開発](#test-driven-development) - テスト主導の開発プロセス
- [UI/UX ガイドライン](#uiux-guidelines) - UI/UX 設計・実装ルール
- [データベース設計](#database-design) - DB 設計と SQL 管理
- [必須チェックリスト](#essential-checklist) - 開発完了の確認項目

## 🔧 MCP (Model Context Protocol)

### Playwright

- **概要**: UI を自動操作してスクリーンショット取得や回帰テストを行う E2E フレームワーク。
- **使うタイミング**: 機能実装後に自律的に画面操作とスクリーンショットで挙動・見た目を検証するとき。

### DeepWiki

- **概要**: OSS リポジトリのドキュメントを MCP 経由で検索できる外部ナレッジベース。
- **使うタイミング**: ユーザーが「このプロジェクトを調べて」と明示的に依頼したとき。

### Supabase

- **概要**: Postgres ベースの BaaS。認証・ストレージ・リアルタイム API を提供。
- **使うタイミング**: CRUD 実装や Row Level Security (RLS) ポリシー設定など DB 操作が必要なとき。

## 📝 ルールの特徴

### 🎯 シンプル・簡潔

- 冗長な説明を排除
- 要点のみに絞った実用的な内容
- 素早い参照が可能
- **1 つの統合ルールファイル**で完結

### 🔄 自動化

- Issue 管理の自動更新
- 一貫性のあるファイル構造
- MCP 活用による効率的な操作

### 🛡️ 品質保証

- **GitHub Issue による一元管理**（Single Source of Truth）
- テスト駆動開発による高品質コード
- エラー防止のためのチェックリスト
- コードレビューの自動化
- セキュリティベストプラクティス

## 🤝 貢献

ルールの改善や新しいルールの追加は歓迎します：

1. 既存ルールの改善提案
2. 新しい技術スタックへの対応
3. ワークフローの最適化

## 📄 ライセンス

このプロジェクトは [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) の下で公開されています。

[![CC BY 4.0][cc-by-shield]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

### ライセンスの内容

- ✅ **再利用可能**: 自由に使用・配布可能
- ✅ **改変可能**: 修正・改変して使用可能
- ✅ **商用利用可能**: 商業目的での使用も可能
- ✅ **帰属表示**: 原作者への適切なクレジット表示が必要

**開発効率と品質の向上を目指して** 🚀
