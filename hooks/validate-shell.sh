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
# git push
if echo "$command" | grep -qE '\bgit\s+push\b'; then
  deny "Do not execute 'git push'. Please ask the user to execute it."
fi

# git merge
if echo "$command" | grep -qE '\bgit\s+merge\b'; then
  deny "Do not execute 'git merge'. Please ask the user to execute it."
fi

# gh コマンド（push/merge 相当）
if echo "$command" | grep -qE '\bgh\s+(pr\s+merge|repo\s+sync)\b'; then
  deny "Do not execute 'gh pr merge' or 'gh repo sync'. Please ask the user to execute it."
fi

# rm -rf（危険な削除）
if echo "$command" | grep -qE '\brm\s+(-rf?|--recursive)\s+/\s*$'; then
  deny "Destructive 'rm -rf /' is prohibited."
fi

# 許可
if [[ "$hook_event" == "beforeShellExecution" ]]; then
  echo '{"permission": "allow"}'
else
  echo '{"decision": "allow"}'
fi
exit 0
