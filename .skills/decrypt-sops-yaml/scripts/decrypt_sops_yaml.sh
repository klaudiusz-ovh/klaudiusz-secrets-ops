#!/usr/bin/env bash
set -euo pipefail

if ! command -v sops >/dev/null 2>&1; then
  echo "Error: required command not found: sops" >&2
  exit 1
fi

src="${1:?encrypted file required}"
dst="${2:-}"

case "$src" in
  *.enc.yaml) : ;;
  *.enc.yml) : ;;
  *)
    echo "Error: input must be .enc.yaml or .enc.yml" >&2
    exit 1
    ;;
esac

if [[ -z "$dst" ]]; then
  case "$src" in
    *.enc.yaml) dst="${src%.enc.yaml}.yaml" ;;
    *.enc.yml)  dst="${src%.enc.yml}.yml" ;;
  esac
fi

sops decrypt --output "$dst" "$src"
chmod 600 "$dst" 2>/dev/null || true
echo "Decrypted: $src -> $dst"