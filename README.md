<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- Copyright 2026 Tomasz Kornuta -->

# Klaudiusz Secrets Operations (SOPS)

Encryption/decryption skills and utilities for managing secrets using Mozilla SOPS + AGE.

## Contents

- `.skills/encrypt-sops-yaml/` — Encrypt plaintext YAML/YML files to SOPS format
- `.skills/decrypt-sops-yaml/` — Decrypt SOPS-encrypted files to plaintext

## Setup

### 1. Install required packages

```bash
# macOS
brew install sops age

# Linux (Ubuntu/Debian)
sudo apt-get update && sudo apt-get install -y age
curl -L https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64 -o sops
chmod +x sops && sudo mv sops /usr/local/bin/
```

### 2. Generate AGE encryption key

Generate your AGE private key (one-time setup):

```bash
mkdir -p ~/.config/sops/age
age-keygen -o -f ~/.config/sops/age/klaudiusz-keys.txt
```

Extract your public key for `SOPS_AGE_RECIPIENTS`:

```bash
grep "^# public key:" ~/.config/sops/age/klaudiusz-keys.txt | sed 's/# public key: //'
```

Save the output — you'll use it in the next step.

### 3. Configure OpenClaw environment

Create `~/.openclaw/.env` with your SOPS credentials (replace `age1...` with the public key from step 2):

```bash
cat > ~/.openclaw/.env <<'EOF'
SOPS_AGE_KEY_FILE=~/.config/sops/age/klaudiusz-keys.txt
SOPS_AGE_RECIPIENTS=age1...
EOF
chmod 600 ~/.openclaw/.env
```

### 4. Restart the gateway

After creating `~/.openclaw/.env`, restart the OpenClaw gateway to load the new environment variables:

```bash
openclaw gateway restart
```

## Quick Start

### Decrypt a secret file

```bash
bash .skills/decrypt-sops-yaml/scripts/decrypt_sops_yaml.sh path/to/file.enc.yaml
```

### Encrypt a plaintext file

```bash
bash .skills/encrypt-sops-yaml/scripts/encrypt_sops_yaml.sh path/to/file.yaml
```

## Requirements

- `sops` — https://github.com/getsops/sops
- `age` — https://github.com/FiloSottile/age

## Documentation

See individual SKILL.md files in `.skills/` for detailed usage.

---

**Note:** This repo contains only encryption utilities and scripts. No secrets or credentials are stored here.
