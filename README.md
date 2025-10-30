# Custom Prompts

[![CC BY 4.0][cc-by-shield]][cc-by]

Custom Prompts は、開発効率と品質を向上させるための独自のプロンプト集です。

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg

## 対応 AI

- Agents
  - [Agents Rules](./AGENTS.md)
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

## ルール構成

### 常時適用ルール

| Agenda              | 説明                                              |
| ------------------- | ------------------------------------------------- |
| instructions        | AI に指示する内容                                 |
| Global Rules        | 基本的な開発原則                                  |
| Execution Workflows | 実行フロー                                        |
| Tech Stack          | 使用技術とバージョン管理                          |
| MCP                 | 使用する MCP のツールと使用タイミング、簡単な説明 |
| Directory Structure | プロジェクト構造とファイル命名規則                |
| UI/UX Guidelines    | UI/UX 設計・実装ルール                            |

### MCPs (Model Context Protocol)

| MCP              | 説明                                                                                                                         |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Next.js DevTools | Next.js 16 以降の開発サーバーと統合し、リアルタイムでアプリケーション情報にアクセス                                          |
| Chrome DevTools  | Chrome DevTools を MCP 経由で操作し、ブラウザの開発者ツール機能を利用可能に                                                  |
| Playwright       | ブラウザの自動操作とエンドツーエンドテストを行う                                                                             |
| DeepWiki         | 外部ナレッジベースから GitHub リポジトリのドキュメントを検索                                                                 |
| Supabase         | PostgreSQL データベース、認証、ストレージ、リアルタイム API を提供（アクセストークン不要、プロジェクトリファレンス ID 必要） |
