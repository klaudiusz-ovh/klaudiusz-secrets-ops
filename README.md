# Klaudiusz Secrets Operations (SOPS)

Encryption/decryption skills and utilities for managing secrets using Mozilla SOPS + AGE.

## Contents

- `.skills/encrypt-sops-yaml/` — Encrypt plaintext YAML/YML files to SOPS format
- `.skills/decrypt-sops-yaml/` — Decrypt SOPS-encrypted files to plaintext

## Quick Start

### Decrypt a secret file

```bash
export SOPS_AGE_KEY_FILE=~/.config/sops/age/klaudiusz-keys.txt
sops -d path/to/file.enc.yaml
```

### Encrypt a plaintext file

```bash
export SOPS_AGE_RECIPIENTS=age1t7lsvgy875c0vytf550r3jqqqnesepyr5ekd9mavcqk7t525k52qjllz0j
bash .skills/encrypt-sops-yaml/scripts/encrypt_sops_yaml.sh path/to/file.yaml
```

## Requirements

- `sops` — https://github.com/getsops/sops
- `age` — https://github.com/FiloSottile/age

## Documentation

See individual SKILL.md files in `.skills/` for detailed usage.

---

**Note:** This repo contains only encryption utilities and scripts. No secrets or credentials are stored here.
