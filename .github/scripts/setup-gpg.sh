#!/usr/bin/env bash
# setup-gpg.sh
# Helper script to configure a local GPG environment for code signing.
# Run this once on your local machine before signing commits or files.
#
# Usage: bash .github/scripts/setup-gpg.sh

set -euo pipefail

echo "=== GPG Local Setup ==="

# ── 1. Check prerequisites ──────────────────────────────────────────────────
if ! command -v gpg &>/dev/null; then
  echo "ERROR: gpg is not installed. Install it and re-run this script." >&2
  exit 1
fi

# ── 2. List existing secret keys ────────────────────────────────────────────
echo ""
echo "Existing secret keys:"
gpg --list-secret-keys --keyid-format=long || true

# ── 3. Optional: import a key from file ─────────────────────────────────────
if [[ -n "${GPG_KEY_FILE:-}" ]]; then
  echo ""
  echo "Importing key from: $GPG_KEY_FILE"
  gpg --import "$GPG_KEY_FILE"
fi

# ── 4. Select the signing key ────────────────────────────────────────────────
echo ""
if [[ -z "${GPG_KEY_ID:-}" ]]; then
  echo "Enter the GPG key ID you want to use for signing"
  echo "(e.g. the 16-character hex ID shown above):"
  read -r GPG_KEY_ID
fi

if [[ -z "$GPG_KEY_ID" ]]; then
  echo "ERROR: No GPG key ID provided." >&2
  exit 1
fi

echo "Using key: $GPG_KEY_ID"

# ── 5. Configure git to sign commits with this key ──────────────────────────
git config --global user.signingkey "$GPG_KEY_ID"
git config --global commit.gpgsign true
git config --global tag.gpgsign true
echo "git configured to sign commits and tags with key $GPG_KEY_ID"

# ── 6. Export the public key (for sharing / uploading to GitHub) ─────────────
PUB_KEY_FILE="gpg-public-key.asc"
gpg --armor --export "$GPG_KEY_ID" > "$PUB_KEY_FILE"
echo ""
echo "Public key exported to: $PUB_KEY_FILE"
echo "Upload this file's contents to GitHub → Settings → SSH and GPG keys."

# ── 7. Export the private key (for adding to GitHub Secrets) ─────────────────
echo ""
echo "To export your private key for use as the GPG_PRIVATE_KEY GitHub Secret, run:"
echo "  gpg --armor --export-secret-keys $GPG_KEY_ID"
echo ""
echo "Then add the output as the GPG_PRIVATE_KEY secret in your repository settings."
echo ""
echo "=== Setup complete ==="
