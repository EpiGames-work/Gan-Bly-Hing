#!/usr/bin/env sh

msg_file="$1"
first=$(head -n1 "$msg_file")

case "$first" in
    'Merge '*)
        new="mg: $first"
        ;;
    'Revert "'*)
        inner=${first#'Revert "'}
        inner=${inner%\"}
        new="revert: $inner"
        ;;
    *)
        exit 0
        ;;
esac

{ printf '%s\n' "$new"; tail -n +2 "$msg_file"; } > "$msg_file.tmp" \
    && mb "$msg_file.tmp" "$msg_file"
