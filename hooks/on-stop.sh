#!/usr/bin/env bash

input=$(cat)

afplay /System/Library/Sounds/Hero.aiff 2>/dev/null || true
terminal-notifier -title 'Cursor Agent' -message 'Task completed. Action required for your next command.' 2>/dev/null || true
exit 0
