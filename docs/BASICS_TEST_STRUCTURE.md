# Solana Program Basics Code Eval Proposal

This document proposes a structure for running tests against the
[solana-developers/program-examples](https://github.com/solana-developers/program-examples)
repository. The focus is on the programs found in the `/basics` directory.

## A. Creating runnable tests

1. **Docker environment**
   - Build an image named `solana-eval` that includes the Rust toolchain with
     BPF support, the Solana CLI (including `solana-test-validator`), and the
     `anchor` CLI for Anchor-based examples.
   - The Dockerfile also clones the `program-examples` repository at a pinned
     commit so tests do not rely on network access at runtime.

2. **Test scripts**
   - Provide a script `scripts/test_example.sh` that receives the path to an
     example (e.g. `basics/hello-world`) and runs the tests for that program.
   - For plain Rust examples the script uses `cargo test-bpf`.
   - For Anchor examples the script uses `anchor test`.
   - Each example directory contains a `tests/` folder with integration tests
     exercising the program's instruction handlers using
     `solana-test-validator`.

3. **CI integration**
   - The evaluation harness builds the docker image and runs
     `scripts/test_example.sh <example>` for the target example. All tests must
     pass for a submission to succeed.

## B. Submission process

1. Each evaluation dataset contains the code for a single example from
   `program-examples` plus the test files described above.
2. Agents clone the dataset, build the docker image if needed, and run the
   provided test script. Failing tests indicate the portions of the program
   that must be completed or corrected.
3. Agents edit the program source or tests, run the script until it reports
   success, and then submit their git diff (or pull request) as the answer.

## C. Agent workflow

1. Build and start the container:
   ```bash
   docker build -t solana-eval .
   docker run --rm -it -v $(pwd):/workspace solana-eval bash
   ```
2. Inside the container run tests for the target example:
   ```bash
   ./scripts/test_example.sh basics/hello-world
   ```
3. Modify source files using typical tools (`vim`, `nano`, etc.), re-run the
   tests, and commit the changes when all tests pass.
4. Produce a patch or open a pull request with the committed changes.

## Basic tasks & frameworks

The `/basics` directory contains introductory Solana programs. Example tasks
that can be turned into code evaluations include:

- `hello-world`: log a greeting. Framework: plain Rust with the
  `solana-program` crate. Tests run via `cargo test-bpf`.
- `counter`: maintain an on-chain counter. Framework: Anchor. Tests run via
  `anchor test`.
- `transfer`: move lamports between accounts. Framework: plain Rust.
- `pda-example`: demonstrate program derived addresses. Framework: Anchor.

Each task's tests validate the correct instruction logic by interacting with
`solana-test-validator` inside the docker container.


