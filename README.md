# Dockerized firestore emulator

This repo describes how to build and run a docker image with [Firestore emulator](https://cloud.google.com/firestore/docs/emulator). It is suitable for testing and development.

## Running

### Manually

Clone the repo, build and run the image like this.

```shell
docker build -t firestore-emulator .
docker run -e PORT=8303 -it firestore-emulator
```

## Docker Compose

Adding the emulator to your docker compose stack is simple. Just add the `firestore` service like the example below.

```yaml
services:
  firestore:
    build:
      context: https://github.com/alexanderczigler/docker-firestore-emulator.git
    environment:
      PORT: 8303
    ports:
      - 8303:8303
```
