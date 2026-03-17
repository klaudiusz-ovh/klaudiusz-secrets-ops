<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- Copyright 2026 Tomasz Kornuta -->

# Klaudiusz Secrets Operations (SOPS)

Encryption/decryption skills and utilities for managing secrets using Mozilla SOPS + AGE.

## Contents

- `.skills/encrypt-sops-yaml/` — Encrypt plaintext YAML/YML files to SOPS format
- `.skills/decrypt-sops-yaml/` — Decrypt SOPS-encrypted files to plaintext

## Quick Start

### Decrypt a secret file

```bash
export SOPS_AGE_KEY_FILE=<path-to-your-age-private-key-file>.txt
bash .skills/decrypt-sops-yaml/scripts/decrypt_sops_yaml.sh path/to/file.enc.yaml
```

### Encrypt a plaintext file

```bash
export SOPS_AGE_RECIPIENTS=<your-age-public-key>
bash .skills/encrypt-sops-yaml/scripts/encrypt_sops_yaml.sh path/to/file.yaml
```

## Requirements

- `sops` — https://github.com/getsops/sops
- `age` — https://github.com/FiloSottile/age

## Documentation

See individual SKILL.md files in `.skills/` for detailed usage.

---

**Note:** This repo contains only encryption utilities and scripts. No secrets or credentials are stored here.
