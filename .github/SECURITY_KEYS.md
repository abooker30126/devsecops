# Security Keys & GPG Signature Guide

This document explains how to set up GPG signing for this repository, configure the required GitHub Secrets, and verify signatures created by the automated workflow.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Generate a GPG Key](#generate-a-gpg-key)
3. [Configure GitHub Secrets](#configure-github-secrets)
4. [Local Git Signing Setup](#local-git-signing-setup)
5. [Verifying File Signatures](#verifying-file-signatures)
6. [Workflow Behaviour](#workflow-behaviour)

---

## Prerequisites

- GPG (GnuPG) installed locally — `gpg --version`
- Repository admin access to configure GitHub Secrets

---

## Generate a GPG Key

If you do not yet have a GPG key (or need a new one):

```bash
gpg --full-generate-key
```

Select **RSA and RSA**, key size **4096**, and a suitable expiry. When prompted, enter your name and email.

List your keys to find the key ID:

```bash
gpg --list-secret-keys --keyid-format=long
```

Example output:

```
sec   rsa4096/B732B308C0FE0BB3 2024-01-01 [SC]
      C8040559438A554CAD747154B732B308C0FE0BB3
uid                 [ultimate] Your Name <you@example.com>
```

The key ID is `B732B308C0FE0BB3`.

---

## Configure GitHub Secrets

Two secrets are required by the workflow:

| Secret name       | Value                                         |
|-------------------|-----------------------------------------------|
| `GPG_PRIVATE_KEY` | ASCII-armored exported private key (see below)|
| `GPG_PASSPHRASE`  | Passphrase protecting the private key         |

### Export the private key

```bash
gpg --armor --export-secret-keys B732B308C0FE0BB3
```

Copy the full output (including the `-----BEGIN PGP PRIVATE KEY BLOCK-----` header and footer) and paste it as the value of the `GPG_PRIVATE_KEY` secret.

### Add secrets to GitHub

1. Open your repository on GitHub.
2. Go to **Settings → Secrets and variables → Actions**.
3. Click **New repository secret** for each secret above.

---

## Local Git Signing Setup

Run the provided helper script to configure your local environment:

```bash
bash .github/scripts/setup-gpg.sh
```

Or configure manually:

```bash
git config --global user.signingkey B732B308C0FE0BB3
git config --global commit.gpgsign true
git config --global tag.gpgsign true
```

---

## Verifying File Signatures

Each signed file will have a corresponding `.gpg.sig` file in the same directory.

### Import the signer's public key

```bash
gpg --import gpg-public-key.asc
```

Or fetch it directly from a key server:

```bash
gpg --keyserver keyserver.ubuntu.com --recv-keys B732B308C0FE0BB3
```

### Verify a single file

```bash
gpg --verify path/to/file.sh.gpg.sig path/to/file.sh
```

A successful verification looks like:

```
gpg: Signature made Mon 01 Jan 2024 00:00:00 UTC
gpg:                using RSA key B732B308C0FE0BB3
gpg: Good signature from "Your Name <you@example.com>"
```

### Verify all signatures in the repository

```bash
find . -name '*.gpg.sig' | while read -r sig; do
  original="${sig%.gpg.sig}"
  echo "Verifying: $original"
  gpg --verify "$sig" "$original" && echo "  OK" || echo "  FAILED"
done
```

---

## Workflow Behaviour

The **GPG Sign Modified Files** workflow (`.github/workflows/gpg-sign-files.yml`) runs automatically on every pull request event (`opened`, `synchronize`, `reopened`).

1. Identifies files modified in the PR that match these extensions:
   - `.sh` — shell scripts
   - `.py` — Python scripts
   - `.yml` / `.yaml` — YAML configuration files
   - `.tf` — Terraform files
2. Signs each matching file with a detached ASCII-armored GPG signature.
3. Commits the resulting `.gpg.sig` files back to the PR branch.
4. Posts a comment to the PR summarising which files were signed.

Files and directories listed in [`.gpg-ignore`](../.gpg-ignore) at the repository root are excluded from signing.
