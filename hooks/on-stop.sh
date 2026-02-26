#!/usr/bin/env bash
# エージェント完了時（Claude の Stop 相当）
cat > /dev/null
afplay /System/Library/Sounds/Hero.aiff 2>/dev/null || true
terminal-notifier -title 'Cursor Agent' -message 'Task completed successfully!' 2>/dev/null || true
exit 0
