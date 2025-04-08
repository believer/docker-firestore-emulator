# Dockerized firestore emulator

This repo describes how to build and run a docker image with [Firestore emulator](https://cloud.google.com/firestore/docs/emulator). It is suitable for testing and development.

## Running

Below are two examples describing how to use this image. Remember that you may need to set `FIRESTORE_EMULATOR_HOST` and `GOOGLE_CLOUD_PROJECT` in your environment if you are using Google's Firestore SDK.

### Manually

Clone the repo, build and run the image like this.

```shell
docker build -t firestore-emulator .
docker run -e PORT=8303 -it firestore-emulator
```

Once it is running, you can access it on `localhost:8303`.

### With Docker Compose

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

When you run `docker compose up` the image will be built and run in your stack.
