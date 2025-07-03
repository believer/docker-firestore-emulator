FROM eclipse-temurin:21-jre

# Install dependencies for gcloud
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg

# Install gcloud CLI and Firestore emulator
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
 && apt-get update \
 && apt-get install -y google-cloud-cli google-cloud-cli-firestore-emulator

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Run Firestore emulator
ENV PORT=8303
CMD ["gcloud", "emulators", "firestore", "start", "--host-port=0.0.0.0:8303"]
