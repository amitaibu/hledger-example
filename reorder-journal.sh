#!/bin/bash

if ! [ -x "$(command -v hledger)" ]; then
  echo 'Error: hledger is not installed.' >&2
  exit 1
fi

LEDGER_FILE="$1"

if [[ -z "$LEDGER_FILE" ]]; then
  echo "Please specify the ledger file in the first argument. ./reorder-journal.sh hledger.journal"
  exit 1
fi

TMPFILE_SORTED=$(mktemp /tmp/hledger.XXXXXX)
TMPFILE_SKELETON=$(mktemp /tmp/hledger.XXXXXX)

hledger print -f "$LEDGER_FILE" > "$TMPFILE_SORTED"

sed '/;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/q' "$LEDGER_FILE" > "$TMPFILE_SKELETON"

cat "$TMPFILE_SKELETON" "$TMPFILE_SORTED" > "$LEDGER_FILE"

rm "$TMPFILE_SORTED" "$TMPFILE_SKELETON"
