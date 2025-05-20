# Build stage to clone program examples
FROM rust:1.73-slim AS builder

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config libssl-dev curl git ca-certificates npm && rm -rf /var/lib/apt/lists/*

# Install Solana CLI and Anchor
RUN curl -sSfL https://release.solana.com/v1.16.17/install | bash -s -- -y
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"
RUN npm install -g @coral-xyz/anchor-cli

WORKDIR /examples
ARG PROGRAM_EXAMPLES_COMMIT=main
RUN git clone https://github.com/solana-developers/program-examples.git \
    && cd program-examples && git checkout $PROGRAM_EXAMPLES_COMMIT

# Final image
FROM rust:1.73-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config libssl-dev curl git ca-certificates npm && rm -rf /var/lib/apt/lists/*
RUN curl -sSfL https://release.solana.com/v1.16.17/install | bash -s -- -y
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"
RUN npm install -g @coral-xyz/anchor-cli

WORKDIR /examples/program-examples
COPY --from=builder /examples/program-examples/basics ./basics

WORKDIR /workspace
CMD ["bash"]
