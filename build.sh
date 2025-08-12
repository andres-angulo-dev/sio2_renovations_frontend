#!/bin/bash

echo "🧹 Cleaning the project..."
flutter clean

echo "🚀 Compilation Flutter Web..."
flutter build web --release

echo "🛠️ Generating the sitemap..."
dart run bin/generate_sitemap.dart

echo "✅ Build completed with sitemap.xml generated in build/web!"
