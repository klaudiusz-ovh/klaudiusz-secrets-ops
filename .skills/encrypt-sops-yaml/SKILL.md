<!-- SPDX-License-Identifier: Apache-2.0 -->
<!-- Copyright 2026 Tomasz Kornuta -->

---
name: encrypt-sops-yaml
description: Encrypt one plaintext YAML/YML file or many plaintext YAML/YML files into SOPS-managed .enc.yaml/.enc.yml files using the SOPS_AGE_RECIPIENTS environment variable. Use when you need to create or refresh encrypted secret files for Git.
---

# Encrypt SOPS YAML

Use this skill when plaintext YAML/YML secret files need to be encrypted for storage in Git.

## Preconditions

- `sops` is installed and available on PATH.
- `SOPS_AGE_RECIPIENTS` is set to one or more comma-separated age public recipients.
- The input files exist and are plaintext YAML or YML.
- The repository's `.gitignore` ignores plaintext secret YAML files.

## Scripts

- `scripts/encrypt_sops_yaml.sh` encrypts one file.
- `scripts/encrypt_all_sops_yaml.sh` recursively encrypts all matching plaintext files under one or more paths.

## Single-file usage

```bash
bash scripts/encrypt_sops_yaml.sh path/to/file.yaml
```

Optional explicit output path:

```bash
bash scripts/encrypt_sops_yaml.sh path/to/file.yaml path/to/file.enc.yaml
```

## Bulk usage

```bash
bash scripts/encrypt_all_sops_yaml.sh secrets/
```

Multiple paths:

```bash
bash scripts/encrypt_all_sops_yaml.sh secrets/ infra/ personal/
```

## Bulk behavior

1. Recursively finds `*.yaml` and `*.yml` files.
2. Skips files already ending in `.enc.yaml` or `.enc.yml`.
3. Skips common plaintext scratch files such as `*.dec.yaml`, `*.decrypted.yaml`, and `*.plaintext.yaml`.
4. Writes encrypted siblings next to the source files.
5. Prints a summary and fails if any file cannot be encrypted.

## Notes

- Keep plaintext files ignored by Git.
- Commit only the encrypted `*.enc.yaml` / `*.enc.yml` files.
- This skill assumes `.sops.yaml` is already present in the repo.
