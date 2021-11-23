# FROM solanalabs/rust:$RUSTVERSION
ARG RUSTV
ARG SOLANAV
FROM  solanalabs/solana:$SOLANAV as solanasource

FROM solanalabs/rust:$RUSTV

WORKDIR /app

COPY build-verify.sh /build-verify.sh

CMD /build-verify.sh

COPY --from=solanasource /usr/bin/solana /usr/bin/solana
COPY --from=solanasource /usr/bin/cargo-build-bpf /usr/bin/cargo-build-bpf
COPY --from=solanasource /usr/bin/sdk /usr/bin/sdk