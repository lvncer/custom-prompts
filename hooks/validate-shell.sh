#!/usr/bin/env bash
# validate-shell.sh - beforeShellExecution で Shell コマンドを検証
# sandbox.json の権限バイパスがあっても、このフックは実行される

input=$(cat)

# beforeShellExecution: .command / preToolUse: .tool_input.command
command=$(echo "$input" | jq -r '.command // .tool_input.command // ""')
hook_event=$(echo "$input" | jq -r '.hook_event_name // ""')

# beforeShellExecution 用の deny 出力
deny_before_shell() {
  jq -n --arg msg "$1" '{
    "permission": "deny",
    "user_message": $msg,
    "agent_message": $msg
  }'
  exit 0
}

# preToolUse 用の deny 出力（互換のため残す）
deny_pre_tool() {
  jq -n --arg reason "$1" '{"decision": "deny", "reason": $reason}'
  exit 0
}

deny() {
  if [[ "$hook_event" == "beforeShellExecution" ]]; then
    deny_before_shell "$1"
  else
    deny_pre_tool "$1"
  fi
}

# preToolUse の場合、Shell ツール以外はスキップ
if [[ "$hook_event" == "preToolUse" ]]; then
  tool_name=$(echo "$input" | jq -r '.tool_name // ""')
  if [[ "$tool_name" != "Shell" ]]; then
    echo '{"decision": "allow"}'
    exit 0
  fi
fi

# 禁止コマンドのチェック（単語境界で誤検知を防ぐ）
if echo "$command" | grep -qE '\bawk\b'; then
  deny "Use of 'awk' is prohibited. Use 'perl' instead. Example: perl -lane 'print \$F[0]' file.txt"
fi

if echo "$command" | grep -qE '\bsed\b'; then
  deny "Use of 'sed' is prohibited. Use 'perl' instead. Example: perl -pi -e 's/old/new/g' file.txt"
fi

if echo "$command" | grep -qE '\bpush\b'; then
  deny "Do not execute 'git push'. Please ask the user to execute it."
fi

if echo "$command" | grep -qE '\bgit\s+add\s+(-A|--all|\.)(\s|$|[ ;|&])'; then
  deny "Do not git-add all files. Specify the file name(s) to add."
fi

if echo "$command" | grep -qE 'rm\s+(-rf?|--recursive)\s+/\s*$'; then
  deny "Destructive 'rm -rf /' is prohibited."
fi

# 許可
if [[ "$hook_event" == "beforeShellExecution" ]]; then
  echo '{"permission": "allow"}'
else
  echo '{"decision": "allow"}'
fi
exit 0
