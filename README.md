# Solana Code Evals

Evals for testing how good AI agents are at writing code!

To try an example, build the Docker image and run the test script:

```bash
docker build -t solana-eval .
docker run --rm -v $(pwd):/workspace solana-eval ./scripts/test_example.sh basics/hello-world
```


Additional documentation is available in `docs/BASICS_TEST_STRUCTURE.md` which
explains how to build the included Dockerfile, run `scripts/test_example.sh` for
any of the `/basics` programs from
`solana-developers/program-examples`, and use the sample GitHub Actions workflow
under `.github/workflows/basics.yaml`.

