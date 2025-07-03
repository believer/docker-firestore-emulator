FROM debian:stable-slim

RUN apt update
RUN apt -y install openjdk21-jre-headless apt-transport-https ca-certificates gnupg curl

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN apt update
RUN apt -y install google-cloud-cli google-cloud-cli-firestore-emulator

ENV PORT=8303
CMD gcloud emulators firestore start --host-port=0.0.0.0:${PORT}
