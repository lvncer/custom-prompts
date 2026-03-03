---
name: git-sync-guard
description: Git 作業前にリモート最新を取り込み、non-fast-forward や履歴崩れを防ぐための同期手順を適用する。bare リポジトリと通常リポジトリの両方に対応する。ブランチ作成前、作業開始前、履歴競合の予防が必要な場面で使用する。
---

# Git Sync Guard

## 目的

ローカル参照が古い状態で作業を開始しないようにし、`non-fast-forward` や不要な差分再生成を防ぐ。

## 適用トリガー

- 「最新を取ってから作業したい」
- 「non-fast-forward を避けたい」
- 「bare リポジトリを使っている」
- worktree 作成前 / ブランチ作成前 / 既存ブランチでの再開前

## 実行フロー

以下を順番に実行する。

```md
Progress:

- [ ] 1. リポジトリ種別を判定
- [ ] 2. リモート最新を取得（fetch --prune）
- [ ] 3. 必要に応じてローカル参照を同期
- [ ] 4. ブランチ作成/checkout または worktree 作成へ進む
```

### 1) リポジトリ種別を判定

```sh
git rev-parse --is-bare-repository
```

- `true` の場合: bare 用手順を使う
- `false` の場合: 通常リポジトリ用手順を使う

### 2) リモート最新を取得（共通）

#### 通常リポジトリ

```sh
git fetch --prune origin
```

#### bare リポジトリ

```sh
git --git-dir --prune origin < bare-repo-path > fetch
```

### 3) ローカル参照を同期（必要時）

既存ブランチを再利用する場合は、ローカル参照を `origin/<branch>` に合わせる。

#### 通常リポジトリ

```sh
git checkout <branch>
git reset --hard origin/<branch>
```

#### bare リポジトリ

```sh
git --git-dir <bare-repo-path> update-ref refs/heads/<branch> refs/remotes/origin/<branch>
```

## 使い分けルール

- **ローカル変更を残したい場合**: `reset --hard` は使わず、`stash` または別ブランチ退避を優先
- **既存ブランチが bare 側に存在する場合**: `worktree add` で `-b` を付けない
- **新規ブランチ作成時**: 同期済みの `origin/main` など最新ベースから分岐する

## 既存ブランチ利用の例（bare）

```sh
git --git-dir <bare-repo-path> fetch --prune origin
git --git-dir <bare-repo-path> update-ref refs/heads/<branch> refs/remotes/origin/<branch>
git --git-dir <bare-repo-path> worktree add --track <workspace-root>/<branch-with-slash-replaced> origin/<branch>
```

## 注意点

- `fetch --prune` を省略しない
- 作業開始前に `origin/<branch>` が最新かを前提にする
- 履歴が噛み合わない状態のままコミット作業を進めない
