#!/usr/bin/env bash

cat > /dev/null
afplay /System/Library/Sounds/Bottle.aiff 2>/dev/null || true
terminal-notifier -title 'Cursor Agent' -message 'Action required for your next command.' 2>/dev/null || true
exit 0
