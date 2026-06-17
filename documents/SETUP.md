# セットアップガイド

このリポジトリの `.cursor` 設定（Rules・Skills・Commands・Hooks・SubAgents）を別のプロジェクトに導入し、テンプレートの更新を追跡し続けるためのガイド。

## 仕組み

```txt
lvncers-template/ai-configs (このリポジトリ)
  └── .cursor/
        ├── rules/
        ├── skills/
        ├── commands/
        ├── hooks/
        ├── agents/
        └── skills-lock.json
              ↓ git subtree split で抽出
  cursor-export ブランチ（.cursor の中身がルートになる）
              ↓ git subtree add / pull で取り込み
あなたのプロジェクト
  └── .cursor/  ← テンプレートを追跡
```

`cursor-export` ブランチは `.cursor` の中身だけを切り出した派生ブランチ。
`.cursor` に変更が入るたびに GitHub Actions が自動で更新する。

---

## 利用者向け: 新プロジェクトへの導入

### 前提

- Git 2.x 以上
- プロジェクトが Git リポジトリであること（`git init` 済み）

### 1. 初回セットアップ

```bash
git subtree add \
  --prefix=.cursor \
  git@github.com:lvncers-template/ai-configs.git \
  cursor-export \
  --squash
```

これだけで `.cursor/` にテンプレートが展開される。

> HTTPS を使う場合は `git@github.com:...` を `https://github.com/...` に変える。

### 2. テンプレートの更新を取り込む

```bash
git subtree pull \
  --prefix=.cursor \
  git@github.com:lvncers-template/ai-configs.git \
  cursor-export \
  --squash
```

コンフリクトが出た場合は通常の `git merge` と同じように解消する。

### 3. リモートエイリアスを登録しておくと楽

毎回 URL を書かなくて済む。

```bash
git remote add cursor-template git@github.com:lvncers-template/ai-configs.git

# 以降はこれだけ
git subtree pull --prefix=.cursor cursor-template cursor-export --squash
```

---

## ローカルで上書きしたファイルを守る

`.cursor` 内のファイルをプロジェクト固有にカスタマイズした場合、`subtree pull` でコンフリクトが起きることがある。

**推奨パターン**: テンプレート側は触らず、プロジェクト固有の設定は別ファイルに切り出す。

```txt
.cursor/rules/
  ├── core-development.mdc      ← テンプレートのまま
  └── my-project-specific.mdc  ← プロジェクト独自（上書き被害なし）
```

## メンテナー向け: cursor-export ブランチの管理

### 初回: cursor-export ブランチを作成

```bash
git subtree split --prefix=.cursor -b cursor-export
git push origin cursor-export
```

### 以降: 手動で更新する場合

```bash
git branch -D cursor-export 2> /dev/null || true
git subtree split --prefix=.cursor -b cursor-export
git push origin cursor-export --force
```

> `--force` が必要な理由: `cursor-export` は `main` の履歴を持たない孤立ブランチのため。

### GitHub Actions による自動化

`.github/workflows/cursor-export.yml` が設定済みの場合は、`.cursor/` 配下に変更をプッシュするだけで `cursor-export` が自動更新される（手動操作不要）。

## トラブルシューティング

### `subtree add` でエラーが出る

```sh
fatal: ambiguous argument 'cursor-export': unknown revision
```

`cursor-export` ブランチがまだ存在しない。メンテナーに作成を依頼するか、上の「初回」手順を実行する。

### コンフリクトが大量に出る

`--squash` をつけているとコミット粒度が粗くなり解消が難しいケースがある。
その場合は一度 `.cursor/` を削除してから再度 `subtree add` するのが早い。

```bash
rm -rf .cursor
git subtree add --prefix=.cursor cursor-template cursor-export --squash
```
