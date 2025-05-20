#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <example-path>" >&2
  exit 1
fi

EXAMPLE="$1"

if command -v docker >/dev/null 2>&1; then
  docker build -t solana-eval .
  docker run --rm -v "$(pwd)":/workspace solana-eval \
    ./scripts/test_example.sh "$EXAMPLE"
else
  echo "Docker not found. Running tests locally..." >&2
  ./scripts/test_example.sh "$EXAMPLE"
fi
