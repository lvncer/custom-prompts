# セットアップガイド

人間向けの最短手順。詳細は `.cursor/rules/` とスラッシュコマンドを参照。

## ワークスペース構成

```txt
<workspace-root>/
├── .cursor/           # ハーネス。Cursor はここを開く
├── <project>.git/     # bare
├── main/              # worktree
└── feature-A/         # worktree
```

## 初回（ワークスペースルート）

```bash
curl -fL https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz \
  | tar -xz --strip-components=1 ai-configs-main/.cursor
```

Cursor で `<workspace-root>` を開く。

## worktree へハーネス配布

Cursor 上で `/cursor-sync-tarball` または `/cursor-sync-open` を実行（`workspace_root` と `target` を指定）。

## 配布方式

| 方式                | コマンド               |
| ------------------- | ---------------------- |
| tarball（一方向）   | `/cursor-sync-tarball` |
| submodule（双方向） | `/cursor-sync-open`    |
