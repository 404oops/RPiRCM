#!/bin/bash

PAYLOAD="/opt/rcm/payload.bin"
FUSEE="/opt/rcm/fusee-nano"

echo "Starting RCM Scanner Daemon..."

while true; do
  # Look for the switch in RCM mode
  FOUND=0
  for dev in /sys/bus/usb/devices/*; do
    if [ -f "$dev/idVendor" ] && [ -f "$dev/idProduct" ]; then
      vid=$(cat "$dev/idVendor")
      pid=$(cat "$dev/idProduct")
      if [ "$vid" = "0955" ] && [ "$pid" = "7321" ]; then
         FOUND=1
         DEVICE_PATH="$dev"
         break
      fi
    fi
  done

  if [ "$FOUND" -eq 1 ]; then
    echo "Nintendo Switch in RCM mode detected! Injecting payload..."
    $FUSEE $PAYLOAD
    
    echo "Waiting for device to be disconnected..."
    # Intensely poll the specific device path until it disappears
    while [ -d "$DEVICE_PATH" ]; do
      sleep 0.1
    done
    echo "Device disconnected. Resuming scan."
  else
    sleep 0.1
  fi
done
