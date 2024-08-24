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
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/AUTOMATIC1111

# invokeai
podman build -t container-invokeai \
  --force-rm \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/invokeai/

# comfy
podman build -t container-comfy \
  --force-rm \
  --volume "/opt/stable-diffusion-webuis-podman/data:/data" \
  --volume "/opt/stable-diffusion-webuis-podman/output:/output" \
  --device "nvidia.com/gpu=all" \
  ./services/comfy/

podman play kube --replace webuis.yaml
