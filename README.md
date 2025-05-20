# Solana Code Evals

Evals for testing how good AI agents are at writing code!

This repository includes a Dockerfile and helper script for running tests
against examples from the
[`solana-developers/program-examples`](https://github.com/solana-developers/program-examples)
repository.

To build the image and run a basic example:

```bash
docker build -t solana-eval .
docker run --rm -v $(pwd):/workspace solana-eval test_example.sh basics/hello-world
```

Further documentation lives in `docs/BASICS_TEST_STRUCTURE.md`.

