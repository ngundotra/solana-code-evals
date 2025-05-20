#!/bin/bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <example>" >&2
  exit 1
fi

EXAMPLE=$1
EXAMPLE_DIR=/opt/program-examples/$EXAMPLE

if [[ ! -d "$EXAMPLE_DIR" ]]; then
  echo "Example not found: $EXAMPLE" >&2
  exit 1
fi

cd "$EXAMPLE_DIR"

if [[ -f Anchor.toml ]]; then
  anchor test
else
  cargo test-bpf
fi
