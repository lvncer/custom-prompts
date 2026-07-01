# Slide Slidev

## 概要

完成した原稿（Markdownファイル）をもとに、Slidev用スライドを生成するコマンド。

## 使い方

```sh
/slide-slidev [原稿ファイルのパス]
```

## AIの動き（ステップ）

### STEP 1 — 原稿の読み込み

- ファイルを読んで内容・発表時間・ゴールをメタ情報から取得
- 不明な場合のみ確認（1問だけ）

### STEP 2 — ページ構成の提案（確認あり）

```md
## スライド構成案

| ページ | テンプレート | 内容概要           | 画像     |
| ------ | ------------ | ------------------ | -------- |
| 1      | title        | タイトル・発表者名 | なし     |
| 2      | toc          | 目次               | なし     |
| 3      | sakurai      | 課題の説明         | 生成     |
| 4      | summary      | まとめ3点          | アイコン |

承認しますか？
```

### STEP 3 — Markdownファイルの生成

承認後、テンプレートに従いSlidev用Markdownを出力する。

## 画像ルール

| 状況     | 対応                                                  |
| -------- | ----------------------------------------------------- |
| 画像なし | Lucide アイコンで代用（`lucide-vue-next` からimport） |
| 外部画像 | URLをそのまま `<img src>` に渡す                      |

> 画像に文字を入れるのは絶対禁止。

## 共通設定（全ファイル先頭に必ず入れる）

```yaml
---
theme: default
colorSchema: light
fonts:
  sans: 'Google Sans'
---
```

## スライドテンプレート一覧

### `title` — タイトルスライド

```md
<div class="text-center">
  <h2 class="text-4xl font-semibold pb-8">Title</h2>
  <div class="text-xl text-gray-400">発表者名 · 2026/07/01</div>
</div>
```

### `toc` — 目次

```md
<div class="pt-2 p-8">
  <h1 class="text-4xl font-normal">Agenda</h1>
</div>

<div class="grid gap-1 px-32">
  <div
    v-for="(item, i) in ['項目1', '項目2', '項目3']"
    :key="i"
    class="border border-gray-200 rounded-lg p-4 flex items-center gap-3"
  >
    <span class="pl-1 pr-3 text-2xl font-bold text-gray-300">{{ String(i+1).padStart(2,'0') }}</span>
    <span class="font-medium">{{ item }}</span>
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

### `emphasis` — 強調テキスト型

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
