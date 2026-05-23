# Slide Slidev

## 概要

完成した原稿（Markdownファイル）をもとに、Slidev用スライドを生成するコマンド。

## 使い方

```sh
/slide [原稿ファイルのパス]
```

### 例

```sh
/slide ./draft.md
```

## AIの動き（ステップ）

### STEP 1 — 原稿の読み込み

- ファイルを読んで内容・発表時間・ゴールをメタ情報から取得
- 不明な場合のみ確認（1問だけ）

### STEP 2 — ページ構成の提案（確認あり）

```md
## スライド構成案

| ページ | テンプレート | 内容概要                | 画像     |
| ------ | ------------ | ----------------------- | -------- |
| 1      | title        | タイトル・発表者名      | なし     |
| 2      | toc          | 目次（4項目）           | なし     |
| 3      | sakurai      | 課題の説明              | 生成     |
| 4      | grid-2col    | Before / After          | なし     |
| 5      | steps        | 導入フロー（3ステップ） | なし     |
| 6      | emphasis     | 結論の一言              | なし     |
| 7      | summary      | まとめ3点               | アイコン |

承認しますか？ページ追加・削除・テンプレ変更があればどうぞ。
```

### STEP 3 — Markdownファイルの生成

承認後、テンプレートに従いSlidev用Markdownを出力する。

## 画像ルール

| 状況     | 対応                                                  |
| -------- | ----------------------------------------------------- |
| 画像なし | Lucide アイコンで代用（`lucide-vue-next` からimport） |
| 外部画像 | URLをそのまま `<img src>` に渡す                      |

> 画像に文字を入れるのは絶対禁止。

## スライドテンプレート一覧

Slidev の共通設定（全ファイル先頭に必ず入れる）：

```yaml
---
theme: default
colorSchema: light
fonts:
  sans: 'Google Sans'
---
```

### `title` — タイトルスライド

```md
<div class="text-center">
  <h2 class="text-4xl font-semibold pb-8">Title</h2>
  <div class="text-xl text-gray-400">発表者名 · 2026/05/24</div>
</div>
```

### `toc` — 目次

```md
<div class="pt-2 p-8">
  <h1 class="text-4xl font-normal">Agenda</h1>
</div>

<div class="grid gap-1 px-32">
  <div
    v-for="(item, i) in ['項目1', '項目2', '項目3', '項目4', '項目5']"
    :key="i"
    class="border border-gray-200 rounded-lg p-4 flex items-center gap-3"
  >
    <span class="pl-1 pr-3 text-2xl font-bold text-gray-300">{{ String(i+1).padStart(2,'0') }}</span>
    <span class="font-medium">{{ item }}</span>
  </div>
</div>
```

### `sakurai` — 基本系（桜井流）

横長画像があるときに最強。
上：タイトル（結論）／中：ビジュアル／下：補足2行まで。

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">Sakurai</h1>
</div>

<div class="flex flex-col items-center gap-3 pt-1">
  <img src="./images/bigben.jpg" class="rounded-3xl object-cover max-w-144" />

  <div class="text-2xl text-gray-500 text-center max-w-xl">
    <p>補足1行目。短く、わかりやすく。</p>
    <p>補足2行目。最大2行まで。</p>
  </div>
</div>
```

### `grid-2col` — グリッド2列

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">grid-2col</h1>
</div>

<div class="grid grid-cols-2 gap-6 pt-6 px-12">
  <div class="border rounded-3xl px-12 py-8 flex flex-col gap-3">
    <div class="grid place-items-center gap-3">
      <h3 class="font-normal text-lg">Grid A</h3>
    </div>
    <div class="text-sm text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
    </div>
  </div>
  <div class="border rounded-3xl px-12 py-8 flex flex-col gap-3">
    <div class="grid place-items-center gap-3">
      <h3 class="font-normal text-lg">Grid B</h3>
    </div>
    <div class="text-sm text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
    </div>
  </div>
</div>
```

### `grid-3col` — グリッド3列

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">grid-3col</h1>
</div>

<div class="grid grid-cols-3 gap-5 pt-9">
  <div class="border rounded-2xl p-6 flex flex-col gap-3">
    <div class="grid place-items-center gap-3">
      <h3 class="font-normal text-lg">Grid A</h3>
    </div>
    <div class="text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
    </div>
  </div>
  <div class="border rounded-2xl p-6 flex flex-col gap-3">
    <div class="grid place-items-center gap-3">
      <h3 class="font-normal text-lg">Grid B</h3>
    </div>
    <div class="text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
    </div>
  </div>
  <div class="border rounded-2xl p-6 flex flex-col gap-3">
    <div class="grid place-items-center gap-3">
      <h3 class="font-normal text-lg">Grid C</h3>
    </div>
    <div class="text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
    </div>
  </div>
</div>
```

---

### `grid-2x2` — グリッド2×2（4項目）

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">grid-2x2</h1>
</div>

<div class="px-8 grid grid-cols-2 gap-2 mt-6">
  <div class="border rounded-xl p-6 flex flex-col gap-1">
    <div class="flex">
      <h3 class="pl-2 pt-0.5 font-normal text-lg">Grid A</h3>
    </div>
    <div class="px-6 text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
    </div>
  </div>
  <div class="border rounded-xl p-6 flex flex-col gap-1">
    <div class="flex">
      <h3 class="pl-2 pt-0.5 font-normal text-lg">Grid B</h3>
    </div>
    <div class="px-6 text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
    </div>
  </div>
  <div class="border rounded-xl p-6 flex flex-col gap-1">
    <div class="flex">
      <h3 class="pl-2 pt-0.5 font-normal text-lg">Grid C</h3>
    </div>
    <div class="px-6 text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
    </div>
  </div>
  <div class="border rounded-xl p-6 flex flex-col gap-1">
    <div class="flex">
      <h3 class="pl-2 pt-0.5 font-normal text-lg">Grid D</h3>
    </div>
    <div class="px-6 text-xs text-gray-500 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
    </div>
  </div>
</div>
```

### `steps` — ステップ型

フロー・手順・プロセスの説明。

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">steps</h1>
</div>

<div class="relative flex items-start mt-10">

  <!-- ステップ1 -->
  <div class="flex-1 flex flex-col items-center text-center px-4 relative">
    <div class="w-10 h-10 rounded-full bg-blue-500 text-white flex items-center justify-center font-bold text-lg z-10">1</div>
    <!-- 矢印（線 + 先っぽ） -->
    <div class="absolute top-5 left-[calc(50%+20px)] right-0 h-0.5 bg-gray-300" />
    <div class="absolute top-[17px] right-0 w-0 h-0 border-y-[5px] border-y-transparent border-l-[8px] border-l-gray-300" />
    <p class="font-semibold text-sm">Step 1</p>
    <div class="text-xs text-gray-400 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
      <p>補足5行目。</p>
    </div>
  </div>

  <!-- ステップ2 -->
  <div class="flex-1 flex flex-col items-center text-center px-4 relative">
    <div class="w-10 h-10 rounded-full bg-blue-500 text-white flex items-center justify-center font-bold text-lg z-10">2</div>
    <!-- 矢印（線 + 先っぽ） -->
    <div class="absolute top-5 left-[calc(50%+20px)] right-0 h-0.5 bg-gray-300" />
    <div class="absolute top-[17px] right-0 w-0 h-0 border-y-[5px] border-y-transparent border-l-[8px] border-l-gray-300" />
    <p class="font-semibold text-sm">Step 2</p>
    <div class="text-xs text-gray-400 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
      <p>補足5行目。</p>
    </div>
  </div>

  <!-- ステップ3（最後は矢印なし） -->
  <div class="flex-1 flex flex-col items-center text-center px-4 relative">
    <div class="w-10 h-10 rounded-full bg-blue-500 text-white flex items-center justify-center font-bold text-lg z-10">3</div>
    <p class="font-semibold text-sm">Step 3</p>
    <div class="text-xs text-gray-400 leading-relaxed">
      <p>補足1行目。短く、わかりやすく。</p>
      <p>補足2行目。</p>
      <p>補足3行目。</p>
      <p>補足4行目。</p>
      <p>補足5行目。</p>
    </div>
  </div>
</div>
```

### `emphasis` — 強調テキスト型

一言で刺す。引用にも使う。

通常版：

```md
---
layout: center
---

<div class="flex flex-col items-center justify-center">
  <p class="text-5xl font-semibold leading-tight tracking-tight">
    ここに結論の一文
  </p>
  <p class="text-xl text-gray-400 mt-6">
    必要なら補足を1行
  </p>
</div>
```

引用版（有名人の言葉など）：

```md
---
layout: center
---

<div class="max-w-2xl mx-auto">
  <p class="text-4xl font-bold leading-snug">"原文（英語）"</p>
  <p class="text-2xl text-gray-500 mt-4 italic">「日本語訳」</p>
  <div class="text-right text-sm text-gray-400 mt-8">
    — 人物名 · 場所 · 日付
  </div>
</div>
```

### `summary` — まとめ

```md
<div class="pt-2 px-8">
  <h1 class="text-4xl font-normal">summary</h1>
</div>

<div class="grid gap-1 px-18 pt-16">
  <div
    v-for="(item, i) in ['項目1', '項目2', '項目3']"
    :key="i"
    class="border border-gray-200 rounded-lg p-4 flex items-center gap-3"
  >
    <CheckCircle class="w-6 h-6 text-green-500 shrink-0" :stroke-width="2" />
    <span class="pl-1 pr-3 text-2xl font-bold text-gray-300">Point {{ String(i+1).padStart(2,'0') }}</span>
    <span class="font-medium">{{ item }}</span>
  </div>
</div>

<script setup>
import { CheckCircle } from 'lucide-vue-next'
</script>
```
