# Solana Code Evals

Evals for testing how good AI agents are at writing code!

To try an example, use the helper script which builds the Docker image if
`docker` is available and falls back to running tests locally:

```bash
scripts/run_tests.sh basics/hello-world
```

The previous workflow of manually building the image still works:

```bash
docker build -t solana-eval .
docker run --rm -v $(pwd):/workspace solana-eval ./scripts/test_example.sh basics/hello-world
```

Additional documentation is available in `docs/BASICS_TEST_STRUCTURE.md` which
explains how to build the included Dockerfile, run `scripts/test_example.sh` for
any of the `/basics` programs from
`solana-developers/program-examples`, and use the sample GitHub Actions workflow
under `.github/workflows/basics.yaml`.

## Submission web app
