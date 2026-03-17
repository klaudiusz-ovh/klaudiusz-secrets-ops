#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 Tomasz Kornuta
#
# Recursively decrypt all SOPS-encrypted YAML/YML files
set -euo pipefail

if ! command -v sops >/dev/null 2>&1; then
  echo "Error: required command not found: sops" >&2
  exit 1
fi

if [[ "$#" -lt 1 ]]; then
  echo "Usage: $0 <dir-or-file> [more dirs/files...]" >&2
  exit 1
fi

decrypted=0
failed=0

while IFS= read -r -d '' src; do
  case "$src" in
    *.enc.yaml) dst="${src%.enc.yaml}.yaml" ;;
    *.enc.yml)  dst="${src%.enc.yml}.yml" ;;
    *) continue ;;
  esac

  if sops decrypt --output "$dst" "$src"; then
    chmod 600 "$dst" 2>/dev/null || true
    echo "Decrypted: $src -> $dst"
    decrypted=$((decrypted + 1))
  else
    echo "Failed: $src" >&2
    failed=$((failed + 1))
  fi
done < <(find "$@" -type f \( -name '*.enc.yaml' -o -name '*.enc.yml' \) -print0)

echo "Summary: decrypted=$decrypted failed=$failed"

if [[ "$failed" -gt 0 ]]; then
  exit 1
fi