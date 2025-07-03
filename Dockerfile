FROM debian:stable-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
 && mkdir -p /etc/apt/keyrings

# Add Adoptium (Temurin) key and repo
RUN curl -fsSL https://packages.adoptium.net/gpg | gpg --dearmor -o /etc/apt/keyrings/adoptium.gpg \
 && echo "deb [signed-by=/etc/apt/keyrings/adoptium.gpg] https://packages.adoptium.net/temurin/deb/ stable main" > /etc/apt/sources.list.d/adoptium.list \
 && apt-get update \
 && apt-get install -y temurin-21-jre

# Install Google Cloud SDK + Firestore emulator
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
 && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list \
 && apt-get update \
 && apt-get install -y google-cloud-cli google-cloud-cli-firestore-emulator

# Clean up APT cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set emulator port and start command
ENV PORT=8303
CMD ["gcloud", "emulators", "firestore", "start", "--host-port=0.0.0.0:8303"]
