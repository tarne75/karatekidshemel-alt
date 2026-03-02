#!/usr/bin/env bash
# Run this script once to download images from the live site into assets/images/
# Usage: bash download-images.sh
set -e
mkdir -p assets/images
curl -L "https://karatekidshemel.co.uk/Portals/0/sasorilogo.jpg" -o assets/images/logo.jpg
curl -L "https://karatekidshemel.co.uk/portals/0/B37562D0F8794B7B8CE6FF632A76CDF0.jpg" -o assets/images/chris.jpg
curl -L "https://karatekidshemel.co.uk/portals/0/BEBF21CB1D024ED4948757ABA6536A24.jpg" -o assets/images/marie.jpg
curl -L "https://karatekidshemel.co.uk/portals/0/0002C2CA64E84FC7A01E547A236FBD4F.jpg" -o assets/images/dean.jpg
echo "✓ Images downloaded to assets/images/"
