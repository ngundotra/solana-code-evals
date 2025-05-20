#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <example-path>" >&2
  exit 1
fi

EXAMPLE="$1"
EXAMPLE_DIR="/examples/program-examples/$EXAMPLE"

if [ ! -d "$EXAMPLE_DIR" ]; then
  echo "Example not found: $EXAMPLE_DIR" >&2
  exit 1
fi

cd "$EXAMPLE_DIR"

if [ -f Anchor.toml ]; then
  if command -v anchor >/dev/null 2>&1; then
    anchor test
  else
    echo "Anchor CLI not found. Running host cargo tests instead." >&2
    cargo test -- --nocapture
  fi
else
  if command -v cargo-test-bpf >/dev/null 2>&1; then
    cargo test-bpf
  else
    echo "cargo-test-bpf not found. Running host cargo tests instead." >&2
    cargo test -- --nocapture
  fi
fi
