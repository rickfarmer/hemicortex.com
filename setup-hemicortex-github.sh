#!/usr/bin/env bash
#
# setup-hemicortex-github.sh
# Initialize and push the HemiCortex site to a new GitHub repository.
#
# USAGE:
#   1. Place this script in the root of your extracted hemicortex-site folder.
#   2. Make executable:
#        chmod +x setup-hemicortex-github.sh
#   3. Edit GITHUB_USER and REPO_NAME below.
#   4. Run:
#        ./setup-hemicortex-github.sh

# ——— CONFIGURATION ———
GITHUB_USER="rickfarmer"
REPO_NAME="hemicortex.com"          # desired repo name on GitHub
REPO_DESC="HemiCortex Site MVP"      # repository description
VISIBILITY="public"                  # "public" or "private"

# ——— PREREQUISITES CHECK ———
if ! command -v gh &>/dev/null; then
  echo "❌ ERROR: GitHub CLI (gh) is not installed."
  echo "   Install it via: brew install gh"
  exit 1
fi

# ——— INITIALIZE GIT ———
cd "$(dirname "$0")"
git init
git branch -M main

# ——— README ———
if [ ! -f README.md ]; then
  echo "# HemiCortex Site MVP" > README.md
fi

# ——— CREATE & PUSH REPO ———
if [ "$VISIBILITY" = "private" ]; then
  gh repo create "$GITHUB_USER/$REPO_NAME" \
    --private \
    --description "$REPO_DESC" \
    --source=. \
    --remote=origin \
    --push
else
  gh repo create "$GITHUB_USER/$REPO_NAME" \
    --public \
    --description "$REPO_DESC" \
    --source=. \
    --remote=origin \
    --push
fi

echo
echo "✅ Done! Visit: https://github.com/$GITHUB_USER/$REPO_NAME"