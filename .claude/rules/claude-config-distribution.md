# Claude Code ハーネス配布

## 適用範囲

**すべてのプロジェクトに共通。** 配布方式は常に有効。

`workspace_root` / `target` / worktree への配布は **bare + worktree 運用時だけ** の話。単一リポジトリでは `target` = プロジェクトルート（`.`）として `/claude-sync-*` をそのまま使う。

---

ai-configs の `.claude` は **正本**。プロジェクトごとに内容を変えない。変更は ai-configs の `main` に集約する。

## コマンドを打てる場所

スラッシュコマンドは **`.claude/commands/`** にある。
worktree に `.claude` が無くても、Claude Code をルートで開いていればコマンドは使える。

`/claude-sync-*` は worktree **へハーネスを配布する**コマンド。配布先に `.claude` が無いのが普通。

## 配布方式

| 方式      | いつ使う                  | コマンド                 | worktree への影響        |
| --------- | ------------------------- | ------------------------ | ------------------------ |
| tarball   | 一方向・curl で済ませたい | `/claude-sync-tarball`   | なし（gitignore）        |
| clone     | 一方向・git 認証済み      | `/claude-sync-clone`     | なし（gitignore）        |
| submodule | 双方向・参照管理          | `/claude-sync-submodule` | `.gitmodules` + 参照のみ |

いずれも **ワークスペースルートから** `workspace_root` と `target` を指定して実行する。
