FROM rust:1.73-slim

# install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config libssl-dev ca-certificates curl git nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# install Solana
RUN curl -sSfL https://release.solana.com/v1.16.17/install | bash -s --
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# install anchor CLI
RUN npm install -g @coral-xyz/anchor-cli

# clone program examples (basics only)
WORKDIR /opt
RUN git clone https://github.com/solana-developers/program-examples.git \
    && cd program-examples && git checkout 4ec107a \
    && mv basics /examples && rm -rf * && mv /examples basics

# add helper script
COPY scripts/test_example.sh /usr/local/bin/test_example.sh
RUN chmod +x /usr/local/bin/test_example.sh

WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]
