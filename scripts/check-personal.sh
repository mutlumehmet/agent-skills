#!/bin/bash
# Refuses a commit that adds anything from your personal forbidden list.
#
# The list lives outside the repo, one extended regex per line (# for comments):
#   ${AGENT_SKILLS_FORBIDDEN:-~/.config/agent-skills/forbidden.txt}
# Put your email addresses, usernames, home path, client and project names there.
#
# Install as a pre-commit hook:
#   ln -sf ../../scripts/check-personal.sh .git/hooks/pre-commit
#
# Run by hand against the whole tree:
#   scripts/check-personal.sh --all

set -uo pipefail

LIST="${AGENT_SKILLS_FORBIDDEN:-$HOME/.config/agent-skills/forbidden.txt}"
# Files allowed to name the author
ALLOW='^(LICENSE)$'

if [ ! -f "$LIST" ]; then
  echo "check-personal: no forbidden list at $LIST, skipping (create one to enable the check)" >&2
  exit 0
fi

patterns=$(grep -vE '^\s*(#|$)' "$LIST")
[ -n "$patterns" ] || exit 0

if [ "${1:-}" = "--all" ]; then
  files=$(git ls-files)
else
  files=$(git diff --cached --name-only --diff-filter=ACMR)
fi

found=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  [[ "$f" =~ $ALLOW ]] && continue
  if [ "${1:-}" = "--all" ]; then
    content=$(cat "$f" 2>/dev/null)
  else
    # Only lines this commit adds
    content=$(git diff --cached -U0 -- "$f" | grep '^+' | grep -v '^+++')
  fi
  hits=$(printf '%s\n' "$content" | grep -niE -f <(printf '%s\n' "$patterns") || true)
  if [ -n "$hits" ]; then
    echo "check-personal: personal content in $f:" >&2
    printf '%s\n' "$hits" | head -5 | sed 's/^/    /' >&2
    found=1
  fi
done <<< "$files"

if [ "$found" = 1 ]; then
  echo "check-personal: commit refused. Move the value to a config file or use a neutral example." >&2
  exit 1
fi
exit 0
