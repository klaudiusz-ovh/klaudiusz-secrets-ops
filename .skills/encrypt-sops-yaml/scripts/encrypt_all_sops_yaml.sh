#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 Tomasz Kornuta
#
# Recursively encrypt all plaintext YAML/YML files using SOPS + AGE
set -euo pipefail

if ! command -v sops >/dev/null 2>&1; then
  echo "Error: required command not found: sops" >&2
  exit 1
fi

if [[ -z "${SOPS_AGE_RECIPIENTS:-}" ]]; then
  echo "Error: SOPS_AGE_RECIPIENTS is not set" >&2
  exit 1
fi

if [[ "$#" -lt 1 ]]; then
  echo "Usage: $0 <dir-or-file> [more dirs/files...]" >&2
  exit 1
fi

encrypted=0
failed=0

while IFS= read -r -d '' src; do
  base="$(basename "$src")"

  # skip SOPS config and already-encrypted files
  if [[ "$base" == ".sops.yaml" || "$base" == ".sops.yml" ]]; then
    continue
  fi

  if [[ "$src" == *.enc.yaml || "$src" == *.enc.yml ]]; then
    continue
  fi

  # skip common plaintext scratch files
  if [[ "$src" == *.dec.yaml || "$src" == *.decrypted.yaml || "$src" == *.plaintext.yaml ]]; then
    continue
  fi

  case "$src" in
    *.yaml) dst="${src%.yaml}.enc.yaml" ;;
    *.yml)  dst="${src%.yml}.enc.yml" ;;
    *) continue ;;
  esac

  if sops encrypt --output "$dst" "$src"; then
    echo "Encrypted: $src -> $dst"
    encrypted=$((encrypted + 1))
  else
    echo "Failed: $src" >&2
    failed=$((failed + 1))
  fi
done < <(find "$@" -type f \( -name '*.yaml' -o -name '*.yml' \) -print0)

echo "Summary: encrypted=$encrypted failed=$failed"

if [[ "$failed" -gt 0 ]]; then
  exit 1
fi