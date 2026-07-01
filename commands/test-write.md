# テスト作成

## 概要

新規・既存機能に対するテストを、プロジェクトの規約に沿って追加する。

## 手順

### 1. テスト種別の選定

| 種別         | 向いている対象                                     | 特徴                                     |
| ------------ | -------------------------------------------------- | ---------------------------------------- |
| **ユニット** | 単一関数・コンポーネント・純粋ロジック             | 依存をモックし、高速・隔離して検証       |
| **統合**     | API・DB・外部サービス連携                          | 実モジュールを組み合わせた振る舞いを検証 |
| **E2E**      | 画面遷移・フォーム送信・クリティカルなユーザー操作 | ブラウザから実際の UI を操作して検証     |

### 2. 配置と命名

プロジェクトの既存テスト構成に合わせて配置する。

- ユニット: `src/tests/unit/` または `src/**/__tests__/`
- 統合: `src/tests/integration/`
- E2E: `e2e/` または `tests/e2e/`
- 命名: `AuthButton.test.tsx` / `AuthButton.spec.tsx`

### 3. テストファイルの構成

```ts
import { describe, it, expect, beforeEach } from "bun:test";
import { render, screen } from "@testing-library/react";
import { AuthButton } from "@/components/AuthButton";

describe("AuthButton", () => {
  beforeEach(() => {
    // 共通セットアップ
  });

  it("未ログイン時に「ログイン」を表示する", () => {
    render(<AuthButton user={null} />);
    expect(screen.getByRole("button", { name: /ログイン/ })).toBeInTheDocument();
  });

  it("ログイン時に「ログアウト」を表示する", () => {
    render(<AuthButton user={{ name: "test" }} />);
    expect(screen.getByRole("button", { name: /ログアウト/ })).toBeInTheDocument();
  });
});
```

### 4. モックとフィクスチャ

- **モック**: API クライアント・ルーター・グローバル関数は差し替え可能にする
- **フィクスチャ**: `fixtures/` やテストファイル直下の定数で共有する

### 5. アサーションとエッジケース

- 正常系・境界値・異常系を少なくとも 1 ケースずつカバー

### 6. 作成後の確認

```sh
# 追加したファイルだけ実行
bun test src/tests/unit/AuthButton.test.tsx

# 一括実行
bun run test:unit
```

満たすべき基準

- 追加・変更したテストがすべてグリーンであること
- 既存の他テストを壊していないこと
