#!/usr/bin/env bash
# ツール実行時（Bash/Read/Edit 等）に鳴らす音（Claude の EventName 相当）
cat > /dev/null
afplay /System/Library/Sounds/Morse.aiff 2>/dev/null || true
exit 0
