#!/bin/bash
set -e

echo "=== Installing Flutter SDK ==="
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git flutter
  cd flutter
  git checkout 00b0c91f06209d9e4a41f71b7a512d6eb3b9c694
  cd ..
fi

export PATH="$PATH:$PWD/flutter/bin"

echo "=== Flutter Version ==="
flutter --version

echo "=== Enabling Web and Building WASM ==="
flutter config --enable-web
flutter pub get
flutter build web --wasm

echo "=== Build Complete ==="
