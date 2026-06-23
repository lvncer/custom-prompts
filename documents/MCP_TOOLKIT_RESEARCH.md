# MCP / Plugin Toolkit 調査メモ

調査日: 2026-06-22

このメモは、現状の `.cursor/mcp.json` と `.cursor/settings.json` で使っている MCP / Plugin を対象に、Cursor と Claude Code の両方で使える Plugin / Toolkit が公開されているかを整理したもの。

## 結論

Plugin / Toolkit として優先的に使う候補は `Figma`, `Stripe`, `Supabase`, `AWS`。
`Slack` と `Chrome DevTools` は Plugin 的な配布はあるが、Cursor と Claude Code の両方で同じ温度感の公式 Plugin として扱うには少し確認が必要。
`Next.js DevTools`, `Notion`, `GitKraken`, `DeepWiki` は現時点では MCP 直接設定のままでよさそう。

## 推奨整理

| 判定          | 対象             | 理由                                                                             | 推奨アクション                                                       |
| ------------- | ---------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| Plugin 化推奨 | Figma            | Cursor と Claude Code の両方で公式 Plugin が案内されている                       | `.cursor/mcp.json` の直接設定をやめ、Plugin インストール手順へ寄せる |
| Plugin 化推奨 | Stripe           | 公式 docs が Cursor `/add-plugin stripe` と Claude Code plugin を案内している    | MCP 直接設定より Plugin を優先                                       |
| Plugin 化推奨 | Supabase         | 公式 docs に MCP + Agent Skills を束ねる Plugin がある                           | project_ref を分けたい場合だけ MCP 直接設定を残す                    |
| Plugin 化推奨 | AWS              | 公式 Agent Toolkit / Agent Plugins が MCP + Skills を束ねる                      | Plugin に寄せる。MCP 直接登録との二重登録は避ける                    |
| 要検証        | Slack            | `slackapi/slack-mcp-plugin` はあるが、Cursor は Add button / MCP config 色が強い | Plugin として安定運用できるか確認後に移行                            |
| 要検証        | Chrome DevTools  | Claude Code Plugin は公式案内あり。Cursor は MCP install 案内が中心              | Cursor Plugin が明確に使えるなら移行                                 |
| MCP 継続      | Next.js DevTools | MCP server と `init` ルールが中心。Plugin / Toolkit は見当たらない               | 現状維持                                                             |
| MCP 継続      | Notion           | Claude Code Plugin は案内あり。Cursor は MCP 設定のみ                            | 現状維持                                                             |
| MCP 継続      | GitKraken        | GitLens / GitKraken CLI による MCP 導入が中心                                    | 現状維持                                                             |
| MCP 継続      | DeepWiki         | remote MCP のみ。Plugin / Toolkit は見当たらない                                 | 現状維持                                                             |

## 詳細一覧

| ジャンル           | 現在の対象       | 現在の設定                     | Plugin / Toolkit 有無 | Cursor                      | Claude Code                                                                                                                  | Toolkit / Docs URL                                                                                                 | メモ                                                                                                         |
| ------------------ | ---------------- | ------------------------------ | --------------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| デザイン           | Figma            | `.cursor/mcp.json` remote MCP  | あり                  | `/add-plugin figma`         | `claude plugin install figma@claude-plugins-official`                                                                        | https://github.com/figma/mcp-server-guide                                                                          | MCP server config + Agent Skills + Rules を含む。Plugin へ寄せる価値が高い                                   |
| 決済               | Stripe           | `.cursor/mcp.json` remote MCP  | あり                  | `/add-plugin stripe`        | `claude plugin install stripe@claude-plugins-official`                                                                       | https://docs.stripe.com/skills                                                                                     | 公式が Plugin 推奨。Skills index も公開されている                                                            |
| DB / Backend       | Supabase         | `.cursor/mcp.json` remote MCP  | あり                  | 公式 Plugin あり            | `claude plugin marketplace add supabase/agent-skills` → `claude plugin install supabase@supabase-agent-skills`               | https://supabase.com/docs/guides/ai-tools/plugins                                                                  | MCP + Supabase agent skills を一括導入。プロジェクトごとに `project_ref` を分けたい場合は MCP 直接設定が便利 |
| AWS                | AWS              | `.cursor/settings.json` Plugin | あり                  | Cursor Plugin / Marketplace | `/plugin marketplace add aws/agent-toolkit-for-aws` or `/plugin marketplace add awslabs/agent-plugins`                       | https://docs.aws.amazon.com/agent-toolkit/latest/userguide/plugins.html / https://github.com/awslabs/agent-plugins | `aws-core` 系と `deploy-on-aws` 系の2系統がある。二重登録に注意                                              |
| コラボレーション   | Slack            | `.cursor/mcp.json` remote MCP  | 候補あり              | Add to Cursor / MCP config  | local plugin repo から導入                                                                                                   | https://github.com/slackapi/slack-mcp-plugin                                                                       | Cursor と Claude Code 両方の設定 repo はあるが、公式 marketplace plugin としての導線は要確認                 |
| 開発・デバッグ     | Chrome DevTools  | `.cursor/mcp.json` stdio MCP   | 部分的にあり          | MCP install                 | `/plugin marketplace add ChromeDevTools/chrome-devtools-mcp` → `/plugin install chrome-devtools-mcp@chrome-devtools-plugins` | https://github.com/ChromeDevTools/chrome-devtools-mcp                                                              | Claude Code は Plugin が明確。Cursor は MCP install 案内が中心                                               |
| 開発・デバッグ     | Next.js DevTools | `.cursor/mcp.json` stdio MCP   | 見当たらない          | MCP config                  | `claude mcp add next-devtools npx next-devtools-mcp@latest`                                                                  | https://github.com/vercel/next-devtools-mcp                                                                        | `init` tool を必ず呼ぶ運用が重要。Plugin よりルール化が向いている                                            |
| コラボレーション   | Notion           | `.cursor/mcp.json` remote MCP  | 部分的にあり          | MCP config                  | Notion plugin for Claude Code の案内あり                                                                                     | https://developers.notion.com/guides/mcp/get-started-with-mcp                                                      | Cursor は MCP config の案内のみ。Claude Code 側だけ Plugin があるため、共通 Plugin 化は保留                  |
| Git                | GitKraken        | ルール上で利用想定             | 見当たらない          | GitLens / GitKraken CLI     | `gk mcp` or Claude MCP config                                                                                                | https://github.com/gitkraken/mcp                                                                                   | GitLens 経由または GitKraken CLI 経由。Plugin ではなく MCP install                                           |
| 調査・ドキュメント | DeepWiki         | `.cursor/mcp.json` remote MCP  | 見当たらない          | MCP config                  | `claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp`                                                       | https://docs.devin.ai/work-with-devin/deepwiki-mcp                                                                 | remote MCP のみ。認証不要で軽いので現状維持でよい                                                            |

## AWS Plugin の補足

AWS は Plugin 名と配布元がややこしい。

| 系統                  | 主な Plugin                                           | URL                                          | 用途                                               |
| --------------------- | ----------------------------------------------------- | -------------------------------------------- | -------------------------------------------------- |
| Agent Toolkit for AWS | `aws-core`, `aws-agents`, `aws-data-analytics`        | https://github.com/aws/agent-toolkit-for-aws | AWS MCP Server と主要 Skills の基本セット          |
| Agent Plugins for AWS | `aws-serverless`, `databases-on-aws`, `deploy-on-aws` | https://github.com/awslabs/agent-plugins     | Serverless / Database / Deploy など目的別の Plugin |

`.cursor/settings.json` に両方の系統の Plugin 名が混ざっている場合、実際に Cursor 側で認識される名前か確認してから有効化する。
AWS MCP Server を `.cursor/mcp.json` に手動追加しつつ AWS Plugin も有効化すると、MCP が重複する可能性がある。

## 移行時の注意

| 注意点                             | 内容                                                                                              |
| ---------------------------------- | ------------------------------------------------------------------------------------------------- |
| 二重登録を避ける                   | Plugin が MCP server を含む場合、`.cursor/mcp.json` の同じ MCP 設定は削除する                     |
| 認証方式を確認する                 | OAuth / PAT / API key / local CLI で運用が変わる                                                  |
| project scope が必要なら直接 MCP   | Supabase の `project_ref` など、プロジェクトごとに値を変えたいものは直接 MCP 設定の方が扱いやすい |
| Cursor と Claude Code で導線が違う | 同じ Plugin 名でも install command / marketplace が異なることがある                               |
| 公式 docs 優先                     | 個人ブログの導入例より、公式 docs / 公式 GitHub repo を優先する                                   |
