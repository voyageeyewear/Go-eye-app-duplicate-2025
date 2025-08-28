#!/bin/bash

# Install Flutter dependencies
flutter pub get

# Build Flutter web app
flutter build web --release --no-tree-shake-icons

# Copy build files to the correct location for Vercel
cp -r build/web/* ./

echo "Build completed successfully!"
