#!/bin/bash

if ! [ -x "$(command -v hledger)" ]; then
  echo 'Error: hledger is not installed.' >&2
  exit 1
fi

SEPARATOR=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
LEDGER_FILE="$1"

if [[ -z "$LEDGER_FILE" ]]; then
  echo "Please specify the ledger file in the first argument. ./reorder-journal.sh hledger.journal"
  exit 1
fi

TMPFILE_SORTED=$(mktemp /tmp/hledger.XXXXXX)
TMPFILE_SKELETON=$(mktemp /tmp/hledger.XXXXXX)

if ! hledger print -f "$LEDGER_FILE" > "$TMPFILE_SORTED";
then
  rm "$TMPFILE_SORTED" "$TMPFILE_SKELETON"
  echo "The ledger file is not valid. Run `hledger print` to see the cause of the error."
  exit 1
fi

if [[ 1 -ne $(fgrep "$SEPARATOR" "$LEDGER_FILE" | wc -l) ]];
then
  echo "The ledger file might be corrupted or incompatible with this script."
  exit 1
fi

sed '/'$SEPARATOR'/q' "$LEDGER_FILE" > "$TMPFILE_SKELETON"
echo "" >> "$TMPFILE_SKELETON"

cat "$TMPFILE_SKELETON" "$TMPFILE_SORTED" > "$LEDGER_FILE"

rm "$TMPFILE_SORTED" "$TMPFILE_SKELETON"
