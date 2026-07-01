# プロジェクトワークスペース構成

## 適用範囲

**bare + worktree で複数ブランチを並行作業するときだけ** このルールに従う。
通常の単一リポジトリ（`git clone` してそのディレクトリで作業）では **適用しない**。

## ディレクトリレイアウト（worktree 運用時のみ）

すべて **ワークスペースルート** 直下に並ぶ。ネストしない。

```txt
<workspace-root>/
├── .claude/              # ハーネス（CLAUDE.md / commands / agents）
├── <project>.git/        # bare リポジトリ（例: modern-react.git）
├── main/                 # worktree（ブランチ main）
├── feature-A/            # worktree（ブランチ feature/A → ディレクトリ名は feature-A）
└── ...
```

| パス                               | 役割                                                          |
| ---------------------------------- | ------------------------------------------------------------- |
| `<workspace-root>/.claude/`        | AI ハーネスの正本。スラッシュコマンドは **ここから** 実行する |
| `<workspace-root>/<project>.git/`  | `git --git-dir` の対象。bare                                  |
| `<workspace-root>/<worktree-dir>/` | チェックアウト作業ツリー。アプリコードはここ                  |

worktree ディレクトリ名はブランチ名の `/` を `-` に置換（`feature/foo` → `feature-foo`）。

## 作業の起点（worktree 運用時のみ）

- Claude Code は **`<workspace-root>`** を開く（worktree 単体を開かない）
- シェル操作はルートから `target_path` を指定して worktree に届ける

```sh
cd "<workspace-root>/feature-A" && npm test
```
