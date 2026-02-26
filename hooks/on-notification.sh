#!/usr/bin/env bash

# エージェント応答後＝次の操作待ちの通知（Claude の Notification 相当）
cat > /dev/null
afplay /System/Library/Sounds/Bottle.aiff 2>/dev/null || true
terminal-notifier -title 'Cursor Agent' -message 'Action required for your next command.' 2>/dev/null || true
exit 0
