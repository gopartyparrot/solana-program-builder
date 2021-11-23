#!/bin/bash

set -e

: "${PROJECT?Need to set PROJECT}"

cargo build-bpf --features production --manifest-path $PROJECT/Cargo.toml

echo sha256sum before truncate:
sha256sum /app/target/deploy/*.so

if [[ -z "${PROGRAM_ID}" ]]; then
  echo PROGRAM_ID not set, will not dump onchain program
else
  solana program dump $PROGRAM_ID onchain.so
  truncate -r onchain.so /app/target/deploy/*.so
  sha256sum /app/target/deploy/*.so
  sha256sum onchain.so
fi

if [[ -z "${BUFFER}" ]]; then
  echo BUFFER not set, will not dump buffer
else
  solana program dump $BUFFER buffer.so
  sha256sum buffer.so
fi
