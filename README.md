# RPiRCM

This project generates a custom Raspberry Pi OS image for a RPi Zero 2 W that instantly detects a Nintendo Switch in RCM mode and injects the latest Hekate payload.

## Usage

1. Go into the Releases and download the latest image.
2. Flash it using Balena Etcher or Raspberry Pi Imager.
3. Boot your Raspberry Pi, plug a Nintendo Switch in RCM mode into the OTG USB port, and enjoy!

## Building & Continuous Delivery

1. The `.github/workflows/build.yml` runs automatically on an hourly cron schedule.
2. It fetches the latest release tag from `CTCaer/hekate` and the latest commit hash from `DefenderOfHyrule/fusee-nano`.
3. If a GitHub Release for that exact combination doesn't exist yet, it builds a new one automatically.
4. During the build, it pulls the official `raspberrypi/rpi-image-gen` builder on an `ubuntu-24.04-arm` runner.
5. It compiles `fusee-nano` natively, securely pulls the Hekate payload, and uses `config/rcm-image.yaml` to generate the image.
6. The zero-bloat `.img.xz` is uploaded automatically to the Releases page for you to download.