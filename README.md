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


## Submission web app

A minimal Next.js application for collecting evaluation submissions is available in `submission-app`. It stores submitted patches in a Supabase table named `submissions`.

To run the development server (requires dependencies installed via `npm install`):

```bash
cd submission-app
npm install  # only needed once
cp .env.example .env.local
npm run dev
```

Set the following variables in `.env.local` (see `submission-app/.env.example`) so the API route can write to Supabase:

- `NEXT_PUBLIC_SUPABASE_URL` – your Supabase project URL
- `NEXT_PUBLIC_SUPABASE_ANON_KEY` or `SUPABASE_SERVICE_ROLE_KEY` – API key used by the app

With the server running, open `http://localhost:3000` and submit your patch URL.
