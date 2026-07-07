# セットアップガイド

## パターンの選び方

| 方式      | 必要なもの | 向いている場面                        | worktree への影響        |
| --------- | ---------- | ------------------------------------- | ------------------------ |
| tarball   | curl / tar | 一番シンプルに済ませたい・git 不要    | なし（gitignore）        |
| clone     | git + 認証 | git 認証済み・clone に慣れている      | なし（gitignore）        |
| submodule | git + 認証 | ハーネスの更新を submodule で追いたい | `.gitmodules` + 参照のみ |

## パターン1: tarball（一番シンプル・git不要）

`curl` と `tar` があればよい。
Git 履歴は不要。

```sh
set -euo pipefail

target_path="."
TARBALL_URL="https://github.com/lvncers-template/ai-configs/archive/refs/heads/main.tar.gz"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl -fL "$TARBALL_URL" -o "$tmp_dir/ai-configs.tar.gz"
tar -xzf "$tmp_dir/ai-configs.tar.gz" -C "$tmp_dir"

rm -rf "${target_path}/.claude" "${target_path}/.cursor"
cp -R "$tmp_dir/ai-configs-main/.claude" "${target_path}/"
cp -R "$tmp_dir/ai-configs-main/.cursor" "${target_path}/"
cp "$tmp_dir/ai-configs-main/.claude/CLAUDE.md" "${target_path}/CLAUDE.md"
[ -f "${target_path}/.mcp.json" ] || cp "$tmp_dir/ai-configs-main/.mcp.json" "${target_path}/.mcp.json"

cd "$target_path"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

`.mcp.json` は既に存在する場合コピーしない（プレースホルダを埋めた後の再同期で上書きされないように）。

## パターン2: clone（git 認証済みの場合）

```sh
set -euo pipefail

target_path="."
TEMPLATE_REPO="git@github.com:lvncers-template/ai-configs.git"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

git clone --depth 1 -b main "$TEMPLATE_REPO" "$tmp_dir/ai-configs"

rm -rf "${target_path}/.claude" "${target_path}/.cursor"
cp -R "$tmp_dir/ai-configs/.claude" "${target_path}/"
cp -R "$tmp_dir/ai-configs/.cursor" "${target_path}/"
cp "$tmp_dir/ai-configs/.claude/CLAUDE.md" "${target_path}/CLAUDE.md"
[ -f "${target_path}/.mcp.json" ] || cp "$tmp_dir/ai-configs/.mcp.json" "${target_path}/.mcp.json"

cd "$target_path"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

`.mcp.json` は既に存在する場合コピーしない（プレースホルダを埋めた後の再同期で上書きされないように）。

## パターン3: submodule（双方向・参照を追いたい場合）

`.claude` と `.cursor` をそれぞれ別ブランチの submodule として追加する。

```sh
set -euo pipefail

target_path="."
TEMPLATE_REPO="git@github.com:lvncers-template/ai-configs.git"

cd "$target_path"

git submodule add -b claude-export "$TEMPLATE_REPO" .claude
git submodule add -b cursor-export "$TEMPLATE_REPO" .cursor

cp .claude/CLAUDE.md ./CLAUDE.md
[ -f ./.mcp.json ] || curl -fL "https://raw.githubusercontent.com/lvncers-template/ai-configs/main/.mcp.json" -o ./.mcp.json

rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

`.mcp.json` は `.claude` submodule（`claude-export` ブランチ、`.claude/` 配下のみの subtree split）に含まれないため submodule 化できない。初回のみ curl で取得し、以後は編集後のファイルをそのまま使う。

2回目以降の更新は次のコマンドで同期する（`.mcp.json` は対象外。テンプレート側の変更を取り込みたい場合は手動で差分を確認する）。

```sh
git submodule update --init --remote .claude .cursor
```

## gitignore

tarball / clone を使った場合、配布先の `.gitignore` に追記する。

```gitignore
.claude/
.cursor/
.agents/
CLAUDE.md
skills-lock.json
```

submodule の場合は `.claude/` `.cursor/` はコミット対象（`.gitmodules` 経由の参照）、`.agents/` `CLAUDE.md` `skills-lock.json` は gitignore。

`.mcp.json` はどの方式でも gitignore しない。プレースホルダ（`<PROJECT_REF>` 等）を埋めた実体を配布先リポジトリでコミットして管理する。
