---
name: decrypt-sops-yaml
description: Decrypt one SOPS-managed .enc.yaml/.enc.yml file or many encrypted YAML/YML files into local plaintext YAML/YML files using the local age identity configured for SOPS. Use when a trusted local runtime needs temporary plaintext access.
---

# Decrypt SOPS YAML

Use this skill when encrypted SOPS YAML/YML files need to be decrypted locally.

## Preconditions

- `sops` is installed and available on PATH.
- A local age identity is configured for SOPS, commonly at `~/.config/sops/age/keys.txt`.
- The input file exists and ends with `.enc.yaml` or `.enc.yml`.
- The plaintext output location is ignored by Git.

## Scripts

- `scripts/decrypt_sops_yaml.sh` decrypts one file.
- `scripts/decrypt_all_sops_yaml.sh` recursively decrypts all matching encrypted files under one or more paths.

## Single-file usage

```bash
bash scripts/decrypt_sops_yaml.sh path/to/file.enc.yaml
```

Optional explicit output path:

```bash
bash scripts/decrypt_sops_yaml.sh path/to/file.enc.yaml path/to/file.yaml
```

## Bulk usage

```bash
bash scripts/decrypt_all_sops_yaml.sh secrets/
```

Multiple paths:

```bash
bash scripts/decrypt_all_sops_yaml.sh secrets/ infra/ personal/
```

## Bulk behavior

1. Recursively finds `*.enc.yaml` and `*.enc.yml` files.
2. Decrypts each file next to its encrypted source.
3. Sets restrictive permissions (`chmod 600`) on plaintext outputs when possible.
4. Prints a summary and fails if any file cannot be decrypted.

## Notes

- Prefer decrypting in memory or to a temp path for runtime use.
- Remove plaintext files after use when possible.
- Commit only the encrypted `*.enc.yaml` / `*.enc.yml` files.
