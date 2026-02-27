#!/usr/bin/env bash

input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
command=$(echo "$input" | jq -r '.tool_input.command // ""')

if [[ "$tool_name" != "Shell" ]]; then
  echo '{"decision": "allow"}'
  exit 0
fi

deny() {
  jq -n --arg reason "$1" '{
    "decision": "deny",
    "reason": $reason
  }'
  exit 0
}

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

echo '{"decision": "allow"}'
exit 0
