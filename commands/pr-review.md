# PR レビュー

## 概要

既存 PR を、バグ・リスク・回帰観点で包括的にレビューする。
実行時は **GitKraken MCP を最優先** で使い、未対応操作のみ `gh` をフォールバックで使う。

## 最重要ルール

- AI はレビュー結果を **先に人間へ報告** する
- 人間の明示指示があるまで、PR へのコメント投稿・Approve・Request changes を実行しない
- 「修正案の提示」と「PR への実投稿」は分離する

## 手順

1. 対象 PR を特定する
   - PR URL または PR 番号、対象リポジトリを確認する
   - まず `pull_request_get_detail`（必要なら `gitlens_start_review`）を使う
   - フォールバック（`gh`）:

     ```bash
     gh pr view <PR_NUMBER>
     ```

2. PR 情報と差分を取得する（MCP 優先）
   - `pull_request_get_detail` で PR 本文と変更ファイルを確認する
   - `pull_request_get_comments` で既存レビュー履歴を確認する
   - `repository_get_file_content` で必要なファイル内容を取得し、仕様と差分を突き合わせる
   - 必要に応じて `code_review_branch` を使い、見落としを補助する
   - フォールバック（`gh`）:

     ```bash
     gh pr view <PR_NUMBER> --json title,body,files,reviews,comments
     gh pr diff <PR_NUMBER>
     ```

3. レビュー実施（チェックポイントに沿う）
   - 重大度順（Critical/High/Medium/Low）で問題を抽出する
   - 事実ベースで根拠を示し、再現条件や影響範囲を明示する
   - 修正必須と改善提案を明確に分ける

4. まず人間へ報告する（必須）
   - 先に「レビュー結果サマリ + 指摘一覧」を人間へ提示する
   - 投稿候補文（review body / inline comment 案）を同時に提示する
   - この段階では PR へ書き込まない

5. 人間指示があれば PR へ反映する
   - 「この内容で投稿して」等の明示指示を受けたら投稿する
   - 投稿時は `pull_request_create_review` を最優先で使う
   - 未対応時のみ `gh` を使う
   - フォールバック（`gh`）:

     ```bash
     gh pr review --body "<REVIEW_BODY>" <PR_NUMBER>
     ```

     - 必要であれば、` --comment`, `--request-changes`, `--approve` を追加すること

## レビューチェックポイント

### 1. 正しさ・回帰

- 要件どおりに動作する
- 既存機能を壊していない
- 境界値・異常系・エラーハンドリングが妥当
- 仕様と実装の不一致がない

### 2. 設計・保守性

- 変更範囲が適切（過不足ない）
- 命名・責務分離・依存関係が一貫
- 重複実装や不必要な複雑化がない
- 可読性と将来の変更容易性を確保
- ファイル/フォルダ構成の変更意図が明確

### 3. テスト

- 変更に応じたテスト追加/更新がある
- 失敗時に原因を追えるテストになっている
- 主要フローと回帰観点をカバーしている

### 4. セキュリティ・データ

- 認証/認可の抜け漏れがない
- 入力検証・サニタイズが適切
- 機密情報（キー/トークン/個人情報）を露出していない
- 監査ログや権限制御の前提を壊していない

### 5. パフォーマンス・運用

- 明確な性能劣化を持ち込んでいない
- N+1、不要 I/O、無駄な再計算がない
- 監視・運用時の可観測性を下げていない

## レビュー結果の報告フォーマット

````md
## レビュー結果（人間向け）

### 総評

- <全体評価を 1-3 行>

### 必須修正（Critical/High）

1. [severity] <問題の要約>
   - 根拠: <差分/仕様/再現条件>
   - 影響: <ユーザー影響・障害範囲>
   - 修正案: <最小修正案>

### 改善提案（Medium/Low）

1. [severity] <改善内容>
   - 理由: <保守性/性能/可読性など>
   - 提案: <任意の改善案>

### PR への投稿候補文

- review body:

  <そのまま投稿できる文面>

- inline comment 候補:
  - <file/path>:<line付近> <コメント案>

### フォルダ構造変更がある場合（必須）

- 新規ディレクトリ追加、責務移動、レイヤ分割などの **構造変更を含む PR** は、レビュー報告にツリーを含める
- 可能なら `Before/After` 形式で示し、最低でも `After` は必ず記載する

```sh
[Before]
src/
└── features/
└── billing.ts

[After]
src/
└── features/
└── billing/
├── application/
│ └── create-invoice.ts
├── domain/
│ └── invoice.ts
└── infrastructure/
└── billing-repository.ts
```
````

## 運用メモ

- GitKraken MCP の利用前に、対象ツールのスキーマを確認する
- PR への書き込み系操作（review/comment/approve/request-changes）は、必ず人間の最終確認後に実行する
