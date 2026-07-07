# Claude Code ハーネス配布

## 適用範囲

**すべてのプロジェクトに共通。** 配布方式は常に有効。

`workspace_root` / `target` / worktree への配布は **bare + worktree 運用時だけ** の話。単一リポジトリでは `target` = プロジェクトルート（`.`）として扱う。

---

ai-configs の `.claude` は **正本**。プロジェクトごとに内容を変えない。変更は ai-configs の `main` に集約する。

## 配布は人間が行う

`.claude` を配布先に置くにはまず `.claude` が要る、という自己矛盾があるため、配布用のスラッシュコマンドは存在しない。
worktree など既存の `.claude` が無い場所へ配布する手順は **人間が手元のシェルで実行する**。
tarball / clone / submodule の3パターンは [documents/SETUP.md](/documents/SETUP.md) を参照。
