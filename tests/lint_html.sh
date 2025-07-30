#!/usr/bin/env bash
set -euo pipefail

# Lint all HTML files using tidy.
# tidy must be installed in the environment.

if ! command -v tidy >/dev/null 2>&1; then
    echo "tidy not found. Please install tidy to run HTML lint." >&2
    exit 1
fi

fail=0
while IFS= read -r -d '' file; do
    echo "Checking $file"
    if ! tidy -q -e "$file" >/dev/null; then
        fail=1
    fi
done < <(find . -type f -name '*.html' -print0)

if [ $fail -ne 0 ]; then
    echo "HTML linting failed." >&2
else
    echo "HTML linting passed." >&2
fi
exit $fail
