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
  anchor test
else
  cargo test-bpf
fi
