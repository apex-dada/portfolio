#!/bin/bash
set -e

echo "=== Installing Flutter SDK ==="
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
fi

export PATH="$PATH:$PWD/flutter/bin"

echo "=== Flutter Version ==="
flutter --version

echo "=== Enabling Web and Building WASM ==="
flutter config --enable-web
flutter pub get
flutter build web --wasm

echo "=== Build Complete ==="
