# solana-program-builder

## Build A Local Docker Image

```
docker build --build-arg SOLANAV=v1.7.11 --build-arg RUSTV=1.52.1 --tag sobuilder:v1.7.11 .
```

## Verify A Program

From the work space root:


```
PROGRAM_ID=
PROJECT=

docker run \
 -it \
 --env PROGRAM_ID=$PROGRAM_ID \
 --env PROJECT=$PROJECT \
 -v `pwd`:/app sobuilder:v1.7.11
```