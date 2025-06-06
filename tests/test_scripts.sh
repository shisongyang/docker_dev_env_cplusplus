#!/usr/bin/env bash
set -e

# Find all .sh files excluding .git directory
find . -path './.git' -prune -o -name '*.sh' -type f -print0 | while IFS= read -r -d '' script; do
    echo "Checking $script"
    bash -n "$script"
    echo "OK: $script"
done

echo "All shell scripts passed syntax check."
