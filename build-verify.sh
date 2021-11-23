#!/bin/bash

set -e

: "${PROGRAM_ID?Need to set PROGRAM_ID}"
: "${PROJECT?Need to set PROJECT}"

cargo build-bpf --features production --manifest-path $PROJECT/Cargo.toml

solana program dump $PROGRAM_ID onchain.so
truncate -r onchain.so /app/target/deploy/*.so

sha256sum /app/target/deploy/*.so
sha256sum onchain.so
