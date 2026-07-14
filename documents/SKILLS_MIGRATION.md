# スラッシュコマンド → Skills 移行計画

> P1・P2・P3 すべてのバッチが移行済み。残りは未分類コマンド（下記）の扱い確認のみ。

## 現状と方針

- 現状: `.claude/commands/*.md` にスラッシュコマンドとして実装されている
- 移行先: Skills（`SKILL.md` + frontmatter）
- 移行は一括ではなく段階的に行う。対象コマンドが多く、破壊的操作を含むものもあるため慎重に進める

## 全体アーキテクチャ

新しく `lvncers-template/skills` リポジトリを作成し、Skills の実体（`SKILL.md` 一式）はそちらに置く。
`ai-configs`（このリポジトリ）は Skills の正本という位置づけをやめ、`.claude/skills-lock.json` から `lvncers-template/skills` を参照し、`experimental_install` でローカルに取り込む形に変える。

```txt
lvncers-template/skills（新規リポジトリ・Skills 本体）
├── skills/
│   ├── planning/
│   │   └── grill-with-docs/
│   │       └── SKILL.md
│   ├── testing/
│   │   ├── test-run/SKILL.md
│   │   ├── test-write/SKILL.md
│   │   └── coverage/SKILL.md
│   ├── git/
│   │   ├── commit/SKILL.md
│   │   ├── git-sync/SKILL.md
│   │   └── branch/SKILL.md
│   ├── worktree/
│   │   ├── setup-init-bare/
│   │   │   ├── SKILL.md
│   │   │   └── scripts/          # 手順が複雑なので同梱スクリプト化
│   │   ├── worktree-create-new-branch/SKILL.md
│   │   ├── worktree-create-already-onremote/SKILL.md
│   │   ├── worktree-list/SKILL.md
│   │   └── worktree-remove/SKILL.md
│   └── github/
│       ├── issue-create/SKILL.md
│       ├── pr-create/SKILL.md
│       ├── pr-review/SKILL.md
│       └── pr-review-commit-driven/SKILL.md
└── README.md

ai-configs（このリポジトリ）
└── .claude/
    ├── skills-lock.json   # lvncers-template/skills を参照するロックファイル
    ├── skills/            # `npx skills experimental_install` が生成する実体（コミット対象外）
    └── commands/          # 移行が完了したコマンドから順に削除していく
```

Cursor 側では既に同種の仕組みが稼働している（[.cursor/skills-lock.json](/.cursor/skills-lock.json)）。ただし参照先は `googlechrome/modern-web-guidance` や `wshobson/agents` など複数の外部リポジトリに分散している。今回の Claude Code 移行では、参照先を自前の `lvncers-template/skills` 一本に集約する点が異なる。

## skills-lock.json の役割

`.cursor/skills-lock.json` と同じフォーマットを踏襲する。

```json
{
  "version": 1,
  "skills": {
    "<skill-name>": {
      "source": "lvncers-template/skills",
      "sourceType": "github",
      "skillPath": "skills/<skill-name>/SKILL.md",
      "computedHash": "<hash>"
    }
  }
}
```

インストール・同期は以下のコマンドで行う（`experimental_` 接頭辞の通り実験的機能。コマンド自体が将来変わる可能性がある）。

```sh
npx skills experimental_install
```

**注意（実機検証済みの挙動）**: `experimental_install` は `skills-lock.json` を読んで復元するが、Claude Code 向けの `.claude/skills/` を作らず `.agents/skills/`（全エージェント共通のキャッシュ）にしか復元しない場合がある。ai-configs リポジトリ側で新しいスキルを追加・更新するときは、代わりに以下を使うと確実に `.claude/skills/` に実体がコピーされる。

```sh
npx skills add lvncers-template/skills -s SKILL_NAME -a claude-code --copy -y
```

- `-a claude-code`: 対象エージェントを Claude Code に限定する（省略すると検出できた全エージェント — Cursor・Codex・Kiro CLI 等 — に配布されてしまう）
- `--copy`: `.agents/skills/` へのシンボリックリンクではなく実体ファイルをコピーする（`.agents/` は `.gitignore` 対象のため、シンボリックリンクのままだと配布先で壊れる）
- 実行後、生成された `./skills-lock.json`（リポジトリ直下）を `.claude/skills-lock.json` に移動する（`.cursor/skills-lock.json` と同じ置き場所の流儀に合わせる）

## disable-model-invocation の使い分け

Skills の frontmatter には `disable-model-invocation` を指定できる。

| 値                             | 挙動                                                                                                    |
| ------------------------------ | ------------------------------------------------------------------------------------------------------- |
| 未指定 / `false`（デフォルト） | モデルが会話の文脈から自動判断して呼び出せる                                                            |
| `true`                         | ユーザーが `/<skill-name>` で明示的に呼び出したときのみ実行される。モデルが自律判断で起動することはない |

**方針**: 削除・上書きなど取り消しづらい・破壊的な操作を伴うコマンドは `disable-model-invocation: true` を明示する。どのコマンドを対象にするかは、移行時にユーザーが1つずつ指定する。

現行コマンドのうち候補になりやすいもの（暫定の叩き台。最終判断はユーザー指定を待つ）:

| フェーズ                       | コマンド                                                                                                                                                  | 理由                                                                                                                                                       | 変換時に使うと得な機能                                                                                                                                    |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **P1: 読み取り専用・低リスク** | `grill-with-docs`, `worktree-list`, `coverage`, `pr-review`, `pr-review-commit-driven`                                                                    | 状態変更なし。失敗しても実害ゼロなので練習台に最適                                                                                                         | `worktree-list`は`` !`git worktree list` ``で常に最新状態を注入。`pr-review`系は`context: fork` + `agent: Explore`で軽く回せる                            |
| **P2: 頻用・可逆的**           | `test-run`, `test-write`, `commit`                                                                                                                        | よく使うが、壊れてもgitで戻せる/再実行できる                                                                                                               | `allowed-tools`でテスト実行コマンドを事前承認、プロンプト待ちを減らせる。`commit`は公式docsでも`disable-model-invocation: true`の代表例として挙げられてる |
| **P3: 破壊的・外部に残る**     | `git-sync`, `branch`, `issue-create`, `pr-create`, `worktree-create-new-branch`, `worktree-create-already-onremote`, `worktree-remove`, `setup-init-bare` | push・PR・Issue・ブランチ削除など、GitHub上や作業ツリーに跡が残る                                                                                          | 全部`disable-model-invocation: true`固定。`setup-init-bare`は複雑な手順なので`scripts/`に処理を切り出す価値が特に高い                                     |
| **特例**                       | `/logs`                                                                                                                                                   | 「プロンプトログ保存」は"必ず毎回"動いてほしい系。Claudeの気分次第で発火するSkillより、イベントに紐づいて確実に発火する**Hooks**の方が向いてる可能性が高い | Skill化ではなくHooks移行を先に検討                                                                                                                        |

P1から着手すれば、frontmatteringや動的注入の書き方に慣れつつ、失敗しても被害がないまま経験値が貯まる。P3は一番最後、かつ一つずつ動作確認しながらでいい。

## 移行フロー

```md
Progress:

- [x] 1. lvncers-template/skills リポジトリを作成
- [x] 2. .claude/commands/\*.md を1つずつ SKILL.md 形式に変換し、lvncers-template/skills に配置（P1 の4件のみ）
- [x] 3. 各スキルについて disable-model-invocation の要否をユーザーが指定（P1 は全て未指定でよいと確認済み）
- [x] 4. ai-configs の .claude/skills-lock.json にエントリを追加
- [x] 5. npx skills add ... --copy で取り込み、動作確認（P1〜P3 全15件）
- [x] 6. 動作確認後、対応する .claude/commands/\*.md を削除（P1〜P3 全15件）
- [ ] 7. documents/harness.md の Slash Commands 一覧を更新（.cursor 側のコマンドは今回の対象外のため保留）
- [x] 8. P2（test-run, test-write, commit）の移行
- [x] 9. P3（git-sync, branch, issue-create, pr-create, worktree-create-new-branch, worktree-create-already-onremote, worktree-remove, setup-init-bare）の移行。disable-model-invocation: true を全件に付与
- [ ] 10. 未分類コマンドの扱いをユーザーに確認（下記参照）
```

## P1 移行結果（完了）

以下4件を `lvncers-template/skills` に `SKILL.md` として配置し、ai-configs の `.claude/skills/` にインストール済み。`disable-model-invocation` は指定なし（デフォルト = モデルが自動判断で呼び出し可能）。

| skill                     | 配置先                                           |
| ------------------------- | ------------------------------------------------ |
| `grill-with-docs`         | `skills/planning/grill-with-docs/SKILL.md`       |
| `worktree-list`           | `skills/worktree/worktree-list/SKILL.md`         |
| `pr-review`               | `skills/github/pr-review/SKILL.md`               |
| `pr-review-commit-driven` | `skills/github/pr-review-commit-driven/SKILL.md` |

対応する `.claude/commands/*.md` は削除済み。`.cursor/commands/` 側は今回のスコープ外のため未変更。

## P2 移行結果（完了）

| skill        | 配置先                               | disable-model-invocation |
| ------------ | ------------------------------------ | ------------------------ |
| `test-run`   | `skills/testing/test-run/SKILL.md`   | 未指定（自動起動可）     |
| `test-write` | `skills/testing/test-write/SKILL.md` | 未指定（自動起動可）     |
| `commit`     | `skills/git/commit/SKILL.md`         | `true`                   |

`commit` は「よく使うが可逆的」という P2 の分類ではあるものの、公式ドキュメントで `disable-model-invocation: true` の代表例として挙げられている慣習に合わせ、モデルの自律判断では起動しないようにした。ユーザーが `/commit` と明示したときのみ実行する。

## P3 移行結果（完了）

すべて `disable-model-invocation: true`。GitHub 上や作業ツリーに跡が残る操作、または削除操作のため、ユーザーが明示的に依頼したときのみ実行する。

| skill                              | 配置先                                                                           |
| ---------------------------------- | -------------------------------------------------------------------------------- |
| `git-sync`                         | `skills/git/git-sync/SKILL.md`                                                   |
| `branch`                           | `skills/git/branch/SKILL.md`                                                     |
| `issue-create`                     | `skills/github/issue-create/SKILL.md`                                            |
| `pr-create`                        | `skills/github/pr-create/SKILL.md`                                               |
| `worktree-create-new-branch`       | `skills/worktree/worktree-create-new-branch/SKILL.md`                            |
| `worktree-create-already-onremote` | `skills/worktree/worktree-create-already-onremote/SKILL.md`                      |
| `worktree-remove`                  | `skills/worktree/worktree-remove/SKILL.md`                                       |
| `setup-init-bare`                  | `skills/worktree/setup-init-bare/SKILL.md`（+ `scripts/init-bare-workspace.sh`） |

変換時に、移行前の `.claude/commands/` に既に混入していた壊れたシェルプレースホルダを2件修正した（`git-sync.md` の `git log HEAD..origin/<branch> --oneline` と `worktree-create-new-branch.md` の `git --git-dir <bare-repo-path> fetch --prune origin`。いずれも過去に prettier-plugin-sh が `<placeholder>` をリダイレクト構文と誤解して壊したもの）。

`.claude/skills/` はローカルの生成物として `.gitignore` に追加済み（`.claude/skills-lock.json` のみコミット対象）。`.cursor/skills/` とは異なり実体ファイルはコミットしない方針。

## 未分類コマンド（要確認）

移行対象一覧の作成時、以下は P1/P2/P3 のどれにも分類されていなかった。次のバッチに進む前にユーザーの指定が必要。

| コマンド           | 状況                                                                                                               |
| ------------------ | ------------------------------------------------------------------------------------------------------------------ |
| `submodule-remove` | 未分類。`worktree-remove` と同じく「明確に削除を指示した場合に」実行する既存の記述があり、性質上は P3 相当に見える |
| `slide-draft`      | 未分類。状態変更を伴わない下書き作成                                                                               |
| `slide-slidev`     | 未分類。既存Markdownからスライド生成。ファイル生成はあるが破壊的ではない                                           |
| `coverage`         | P1 表に記載があるが、`.claude/commands/coverage.md` という実体が存在しない。新規作成するか対象外とするか要確認     |

## 現状のステータス

- P1（読み取り専用・低リスク）バッチの移行が完了。lvncers-template/skills への push、ai-configs 側へのインストール、対応する旧コマンドの削除まで完了
- 次のアクション: 上記「未分類コマンド」の扱いと、P2/P3 の着手タイミングをユーザーに確認
