#!/usr/bin/env sh

msg_file="$1"
subject=$(grep -v '^#' "$msg_file" | head -n1)

types='feat|fix|style|chore|devops'
scope='[A-Za-z0-9._/#-]+'

pattern="((mg|pr|revert): .+|(rebase: )?($types)(: $scope)?: [A-Z].*)$"

if ! printf '%s\n' "$subject" | grep -Eq "$pattern"; then
    cat >&2 <<'EOF'

X Invalid commit message.

Expected one of:
    [type]: content
    [type]: scope: content
    [type]: minor|major: content
    rebase: ...
    revert: ...
    mg: ...
    pr: ...

Types: feat, fix, style, chore, devops

Examples:
    feat: auth: Add password reset flow
    fix: major: Merge fix/session-expiry into dev
    rebase: fix: Handle null user in profile page
    mg: Merge tracking branch 'origin/feat/login' into feat/login

EOF
    printf 'Got: %s\n\n' "$subject" >&2
    exit 1
fi
