#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README_PATH="$REPO_ROOT/README.md"
START_MARKER="<!-- VAULTS:START -->"
END_MARKER="<!-- VAULTS:END -->"

if [[ ! -f "$README_PATH" ]]; then
  echo "README.md not found at repo root" >&2
  exit 1
fi

vaults=()
for dir in "$REPO_ROOT"/*/; do
  [[ -d "$dir" ]] || continue

  name="$(basename "$dir")"
  if [[ -d "$dir/.obsidian" ]]; then
    vaults+=("$name")
  fi
done

sorted_vaults=()
if [[ ${#vaults[@]} -gt 0 ]]; then
  while IFS= read -r line; do
    sorted_vaults+=("$line")
  done < <(printf '%s\n' "${vaults[@]}" | LC_ALL=C sort)
fi

section_file="$(mktemp)"
output_file="$(mktemp)"
trap 'rm -f "$section_file" "$output_file"' EXIT

{
  echo "$START_MARKER"
  echo "## Vaults"
  echo

  if [[ ${#sorted_vaults[@]} -eq 0 ]]; then
    echo "_No vaults found yet._"
  else
    echo "| Vault | Path |"
    echo "|---|---|"

    for vault in "${sorted_vaults[@]}"; do
      echo "| $vault | \`$vault/\` |"
    done
  fi

  echo "$END_MARKER"
} > "$section_file"

if grep -qF "$START_MARKER" "$README_PATH" && grep -qF "$END_MARKER" "$README_PATH"; then
  awk -v section_file="$section_file" -v start="$START_MARKER" -v end="$END_MARKER" '
    BEGIN {
      in_block = 0
      inserted = 0
    }

    $0 == start {
      system("cat \"" section_file "\"")
      in_block = 1
      inserted = 1
      next
    }

    $0 == end {
      in_block = 0
      next
    }

    !in_block {
      print
    }

    END {
      if (!inserted) {
        print ""
        system("cat \"" section_file "\"")
      }
    }
  ' "$README_PATH" > "$output_file"
else
  cat "$README_PATH" > "$output_file"
  echo >> "$output_file"
  echo >> "$output_file"
  cat "$section_file" >> "$output_file"
fi

mv "$output_file" "$README_PATH"
echo "Updated vault index in README.md"
