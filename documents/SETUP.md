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
cp "$tmp_dir/ai-configs-main/CLAUDE.md" "${target_path}/CLAUDE.md"

cd "$target_path"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

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
cp "$tmp_dir/ai-configs/CLAUDE.md" "${target_path}/CLAUDE.md"

cd "$target_path"
rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

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

rm -rf .cursor/.agents
cp .cursor/skills-lock.json ./skills-lock.json
npx skills experimental_install
```

2回目以降の更新は次のコマンドで同期する。

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
