#!/usr/bin/env bash

cat > /dev/null
afplay /System/Library/Sounds/Hero.aiff 2>/dev/null || true
terminal-notifier -title 'Cursor Agent' -message 'Task completed successfully!' 2>/dev/null || true
exit 0
