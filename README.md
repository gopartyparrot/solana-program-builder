# solana-program-builder
docker image to build verify solana program


**notice**
user should build/verify program in same environment.

eg, if user A build and deployed program using Ubuntu 20.04 LTS. user B should verify program use Ubuntu 20.04 LTS too.

## build docker image

`docker build --build-arg SOLANAV=$solanaImageVersion --build-arg RUSTV=$solanaRustImageVersion --tag program-builder:0.1 . `

eg:

`docker build --build-arg SOLANAV=v1.6.9 --build-arg RUSTV=1.50.0 --tag program-builder:0.1 . `

## start a container

(before mount program workspace into container, make sure your program code space in the correct branch/tag/commit)

`docker run -it --entrypoint bash --mount type=bind,src=$your_program_workspace_full_path,target=/app/workspace program-builder:0.1`

in your program workspace:

```docker run -it --entrypoint bash --mount type=bind,src=`pwd`,target=/app/workspace program-builder:0.1```

## build program (inside container)

```bash
cd /app/workspace 
cargo-build-bpf --features $yourFeatures
sha256sum target/deploy/xxx.so
# then copy your so somewhere if needed
# rm -rf target 
```

## verify program/buffer

```bash
#first build the program

#config cluster:
#solana config set --url https://api.devnet.solana.com
solana config set --url https://api.mainnet-beta.solana.com

#dump deployed program/buffer:
solana program dump $programIdOrBufferAccount $dumpToFile

#verify deployed program vs local build:
truncate -r $dump.so target/deploy/xxx.so
sha256sum $dump.so target/deploy/xxx.so  

#verify buffer vs local build:
sha256sum $dumpBuffer.so target/deploy/xxx.so  
```
