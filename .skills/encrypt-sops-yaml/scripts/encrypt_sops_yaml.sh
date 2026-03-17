#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0
# Copyright 2026 Tomasz Kornuta
#
# Encrypt a single plaintext YAML file using SOPS + AGE
set -euo pipefail

if ! command -v sops >/dev/null 2>&1; then
  echo "Error: required command not found: sops" >&2
  exit 1
fi

if [[ -z "${SOPS_AGE_RECIPIENTS:-}" ]]; then
  echo "Error: SOPS_AGE_RECIPIENTS is not set" >&2
  exit 1
fi

src="${1:?plaintext file required}"
dst="${2:-}"

case "$src" in
  *.yaml) : ;;
  *.yml) : ;;
  *)
    echo "Error: input must be .yaml or .yml" >&2
    exit 1
    ;;
esac

if [[ -z "$dst" ]]; then
  case "$src" in
    *.yaml) dst="${src%.yaml}.enc.yaml" ;;
    *.yml)  dst="${src%.yml}.enc.yml" ;;
  esac
fi

sops encrypt --age "$SOPS_AGE_RECIPIENTS" --output "$dst" "$src"
echo "Encrypted: $src -> $dst"