# ハーネス集

## Agenda

| Component                                 | 説明                                       |
| ----------------------------------------- | ------------------------------------------ |
| Rules                                     | 永続的な AI ガイダンスとコーディング規約   |
| [Skills](#skills-一覧)                    | 複雑なタスク向けのエージェントの特化機能   |
| [SubAgents](#subagent-一覧)               | カスタムエージェントの設定とプロンプト     |
| [Slash Commands](#slash-commands-一覧)    | エージェントが実行可能なコマンドファイル   |
| [MCP Servers](#mcp-servers)               | Model Context Protocol との連携            |
| [Hooks](#hooks-一覧)                      | イベントによって起動される自動化スクリプト |
| [Execution Controls](#execution-controls) |                                            |

```sh
.cursor/
├── agents/   # Subagents
├── commands/ # Slash Commands
├── hooks/    # Custom Hooks
├── rules/    # Rules
├── skills/   # Skills
│
├── hooks.json
├── mcp.json
└── sandbox.json
```

## 使い方のヒント

[zenn.dev/tkszenn/articles/cafc72cd8d1754](https://zenn.dev/tkszenn/articles/cafc72cd8d1754) を参考にしてください。

## Skills 一覧

skills 一覧のバージョン管理は [/skills-lock.json](/skills-lock.json) を使用しています。
同期は下記コマンドを実行してください。
現状は実験段階であり、実行コマンドが変わる可能性があります。

```sh
npx skills experimental_install
```

新規のskillをインストールする際は、 [https://skills.sh/](https://skills.sh/) からインストールしてください。
コマンド一覧などのドキュメントは [vercel-labs/skills/blob/main/AGENTS.md](https://github.com/vercel-labs/skills/blob/main/AGENTS.md) を確認してください。

以下は私が作成したスキルです。
下記コマンドからインストールできます。

- `nextjs-best-practice`

  ```sh
  npx skills add https://github.com/lvncer/ai-configs/.cursor/skills/nextjs-best-practice/SKILL.md
  ```

- `git-sync-guard`

  ```sh
  npx skills add https://github.com/lvncer/ai-configs/.cursor/skills/git-sync-guard/SKILL.md
  ```

## SubAgent 一覧

| name                                                    | description                                              |
| ------------------------------------------------------- | -------------------------------------------------------- |
| [architect](/.cursor/agents/architect.md)               | システム設計・スケーラビリティ・技術判断の専門家         |
| [planner](/.cursor/agents/planner.md)                   | 複雑な機能実装・リファクタの計画立案専門家               |
| [implementer](/.cursor/agents/implementer.md)           | 実装専門家。計画に沿ってコードを書き、既存パターンに従う |
| [verifier](/.cursor/agents/verifier.md)                 | コード品質・動作の検証専門家。マージ前チェック           |
| [debugger](/.cursor/agents/debugger.md)                 | バグ調査・原因特定・修正の専門家                         |
| [test-runner](/.cursor/agents/test-runner.md)           | テスト設計・実装・実行の専門家                           |
| [security-auditor](/.cursor/agents/security-auditor.md) | セキュリティ監査の専門家。脆弱性検出、OWASP Top 10       |

## Slash Commands 一覧

| command                                                                                    | description                                                                                                         |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------- |
| [grill-with-docs](/.cursor/commands/grill-with-docs.md)                                    | [mattpocock/skills/grill-with-docs](https://www.skills.sh/mattpocock/skills/grill-with-docs) を参考に作成したルール |
|                                                                                            |                                                                                                                     |
| [/cursor-sync-open](/.cursor/commands/cursor-sync-open.md)                                 | `.cursor`, `skills` を同期・起動                                                                                    |
| [/logs](/.cursor/commands/logs.md)                                                         | プロンプトログ保存                                                                                                  |
| [/git-sync](/.cursor/commands/git-sync.md)                                                 | Git 同期・プッシュ解決                                                                                              |
|                                                                                            |                                                                                                                     |
| [/test-run](/.cursor/commands/test.md)                                                     | テスト・ビルド実行                                                                                                  |
| [/test-write](/.cursor/commands/test.md)                                                   | テスト作成                                                                                                          |
| [/coverage](/.cursor/commands/coverage.md)                                                 | テストカバレッジ検証                                                                                                |
|                                                                                            |                                                                                                                     |
| [/issue-create](/.cursor/commands/issue.md)                                                | GitHub Issue 作成・管理                                                                                             |
| [/branch](/.cursor/commands/branch.md)                                                     | ブランチ作成・Git 操作                                                                                              |
| [/worktree-create-new-branch](/.cursor/commands/worktree.md)                               | 新規ブランチから Worktree 作成・起動                                                                                |
| [/worktree-create-already-onremote](/.cursor/commands/worktree-create-already-onremote.md) | 既存リモートブランチから Worktree 作成・起動                                                                        |
| [/worktree-list](/.cursor/commands/worktree-cleanup.md)                                    | Worktree 一覧と状態を取得                                                                                           |
| [/worktree-remove](/.cursor/commands/worktree-cleanup.md)                                  | Worktree 整理・削除                                                                                                 |
| [/commit](/.cursor/commands/commit.md)                                                     | コミット管理・規約                                                                                                  |
| [/pr-create](/.cursor/commands/pr.md)                                                      | プルリクエスト作成・管理                                                                                            |
| [/pr-review](/.cursor/commands/pr.md)                                                      | プルリクエストレビュー                                                                                              |
| [/pr-review-commit-driven](/.cursor/commands/pr-review.md)                                 | コミット駆動プルリクエストレビュー                                                                                  |

### 追加予定コマンド

- 依存関係解消
- テスト駆動開発ワークフロー
- データベース確認
- セキュリティチェック
- AWSデプロイ、監視

## MCP Servers

| MCP                                                                      | 説明                                                                   | 必須プロパティ |
| ------------------------------------------------------------------------ | ---------------------------------------------------------------------- | -------------- |
| [GitKraken](https://help.gitkraken.com/mcp/mcp-getting-started/)         | Git ワークフローに関連する操作                                         |                |
| [Next.js DevTools](https://nextjs.org/docs/app/guides/mcp)               | 開発サーバーのアプリケーション情報にアクセス                           |                |
| [Chrome DevTools](https://github.com/ChromeDevTools/chrome-devtools-mcp) | ブラウザの開発者ツール機能を使用                                       |                |
| [DeepWiki](https://docs.devin.ai/work-with-devin/deepwiki-mcp)           | up-to-date documentation you can talk to, for every repo in the world. |                |
| [Supabase](https://supabase.com/docs/guides/getting-started/mcp)         |                                                                        | `project_ref`  |

## Hooks 一覧

| Trigger              | Shell Scripts                                        | 内容                                                                                                                    |
| -------------------- | ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| beforeShellExecution | [validate-shell.sh](.cursor/hooks/validate-shell.sh) | 禁止コマンドの検証（git push/git merge/gh pr merge/gh repo sync/rm -rf /）。matcher で git/gh/rm を含むコマンドのみ検証 |
| postToolUse          | [on-tool-use.sh](.cursor/hooks/on-tool-use.sh)       | 効果音（Morse）                                                                                                         |
| stop                 | [on-stop.sh](.cursor/hooks/on-stop.sh)               | 効果音（Hero）+ 通知「Task completed. Action required for your next command.」                                          |

> **補足**: `afterAgentResponse`（AI が入力を待っている時の通知）は、エージェントループ中に期待通り発火しないため hooks から削除済み。Cursor の仕様上、該当タイミング専用のフックは未提供。

## Execution Controls

[sandbox.json](/.cursor/sandbox.json) により、エージェントが実行するコマンドのサンドボックス制御が行われる。

### 制御される操作

| 操作                 | 制御内容                                                                                               |
| -------------------- | ------------------------------------------------------------------------------------------------------ |
| **ネットワーク**     | `networkPolicy` で制御。`default: "deny"` の場合、`allow` に指定したドメイン以外へのアクセスをブロック |
| **ファイルシステム** | ワークスペース内への書き込みのみ許可。それ以外のディレクトリは読み取りのみ                             |

### 設定の反映に必要なこと

「Auto-Run in Sandbox」を有効にする必要がある。
Cursor の設定（Settings → Features → Agent）で「Auto-Run in Sandbox」をオンにしないと、`sandbox.json` のポリシーが適用されない。
