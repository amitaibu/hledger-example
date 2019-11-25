#!/bin/bash

if ! [ -x "$(command -v hledger)" ]; then
  echo 'Error: hledger is not installed.' >&2
  exit 1
fi

LEDGER_FILE="$1"

TMPFILE=$(mktemp /tmp/hledger.XXXXXX)

hledger print -f "$LEDGER_FILE" >> "$TMPFILE"


rm "$TMPFILE"
