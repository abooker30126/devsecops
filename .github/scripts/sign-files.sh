#!/usr/bin/env bash
# sign-files.sh
# Signs a single file with GPG and stores the detached signature alongside it.
# Usage: sign-files.sh <file>
#
# Required environment variables:
#   GPG_KEY_ID     - Key ID to use for signing (set by the workflow)
#   GPG_PASSPHRASE - Passphrase for the GPG private key

set -euo pipefail

FILE="${1:-}"

if [[ -z "$FILE" ]]; then
  echo "Usage: $0 <file>" >&2
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "File not found: $FILE" >&2
  exit 1
fi

# Check whether this file matches a .gpg-ignore pattern
if [[ -f ".gpg-ignore" ]]; then
  while IFS= read -r pattern || [[ -n "$pattern" ]]; do
    # Skip blank lines and comments
    [[ -z "$pattern" || "$pattern" == \#* ]] && continue
    # shellcheck disable=SC2053
    if [[ "$FILE" == $pattern ]]; then
      echo "Skipping ignored file: $FILE"
      exit 0
    fi
  done < ".gpg-ignore"
fi

SIG_FILE="${FILE}.gpg.sig"

echo "Signing: $FILE"

# Build the gpg signing command
GPG_SIGN_ARGS=(
  --batch
  --yes
  --detach-sign
  --armor
  --output "$SIG_FILE"
)

if [[ -n "${GPG_KEY_ID:-}" ]]; then
  GPG_SIGN_ARGS+=(--local-user "$GPG_KEY_ID")
fi

if [[ -n "${GPG_PASSPHRASE:-}" ]]; then
  echo "$GPG_PASSPHRASE" | gpg --batch --yes --passphrase-fd 0 \
    "${GPG_SIGN_ARGS[@]}" "$FILE"
else
  gpg "${GPG_SIGN_ARGS[@]}" "$FILE"
fi

# Verify the signature was created successfully
if [[ -f "$SIG_FILE" ]]; then
  echo "Signature created: $SIG_FILE"
  if gpg --verify "$SIG_FILE" "$FILE"; then
    echo "Signature verified successfully."
  else
    echo "Signature verification FAILED for $FILE" >&2
    exit 1
  fi
else
  echo "ERROR: Signature file was not created for $FILE" >&2
  exit 1
fi
