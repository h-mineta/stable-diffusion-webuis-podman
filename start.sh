#!/bin/bash

# download
podman build -t container-download \
  --force-rm \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --device "nvidia.com/gpu=all" \
  ./services/download/

# automatic1111
podman build -t container-automatic1111 \
  --force-rm \
  --build-arg CLI_ARGS="--allow-code --medvram --xformers --enable-insecure-extension-access --api" \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/AUTOMATIC1111

# invoke
podman build -t container-invoke \
  --force-rm \
  --build-arg PRELOAD=true \
  --build-arg CLI_ARGS="--xformers" \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/invoke/

# comfy
podman build -t container-comfy \
  --force-rm \
  --build-arg CLI_ARGS="" \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/comfy/

podman play kube --replace k8s.yaml
