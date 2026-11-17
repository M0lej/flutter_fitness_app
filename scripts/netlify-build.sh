#!/usr/bin/env bash
# Builds the Flutter web app on Netlify.
# The Netlify build image has no Flutter SDK, so the latest stable release
# archive is downloaded (no git clone needed), then the web app is compiled.
set -euo pipefail

FLUTTER_DIR="${FLUTTER_HOME_DIR:-$HOME/flutter-sdk}"
FLUTTER_ROOT_DIR="$FLUTTER_DIR/flutter"
BASE_URL="https://storage.googleapis.com/flutter_infra_release/releases"

# Fetch metadata for the current stable release.
RELEASE_JSON=$(curl -fsSL "$BASE_URL/releases_linux.json" | node -e '
  let s = "";
  process.stdin.on("data", d => s += d).on("end", () => {
    const j = JSON.parse(s);
    const hash = j.current_release.stable;
    const r = j.releases.find(x => x.hash === hash && x.channel === "stable");
    process.stdout.write(JSON.stringify(r));
  });
')
ARCHIVE=$(node -e 'process.stdout.write(JSON.parse(process.argv[1]).archive)' "$RELEASE_JSON")

if [ ! -x "$FLUTTER_ROOT_DIR/bin/flutter" ]; then
  echo "Downloading Flutter SDK: $ARCHIVE"
  mkdir -p "$FLUTTER_DIR"
  curl -fsSL "$BASE_URL/$ARCHIVE" | tar -xJ -C "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_ROOT_DIR/bin:$PATH"

# First invocation builds the Flutter tool (this step clears any version cache).
flutter config --no-analytics

# Flutter normally derives its version by running git commands inside the SDK.
# Those can be unavailable in restricted build environments, which makes the
# SDK report "0.0.0-unknown" and breaks dependency resolution. Writing the
# version cache file up front lets Flutter skip the git lookup entirely.
mkdir -p "$FLUTTER_ROOT_DIR/bin/cache"
ENGINE_REV=""
if [ -f "$FLUTTER_ROOT_DIR/bin/internal/engine.version" ]; then
  ENGINE_REV=$(tr -d '[:space:]' < "$FLUTTER_ROOT_DIR/bin/internal/engine.version")
fi
node -e '
  const r = JSON.parse(process.argv[1]);
  const engine = process.argv[2] || r.hash;
  const date = r.release_date.replace("T", " ").replace(/\.\d+Z$|Z$/, "");
  const out = {
    frameworkVersion: r.version,
    channel: "stable",
    repositoryUrl: "https://github.com/flutter/flutter.git",
    frameworkRevision: r.hash,
    frameworkCommitDate: date,
    engineRevision: engine,
    dartSdkVersion: r.dart_sdk_version || "unknown",
    devToolsVersion: "unknown",
    flutterVersion: r.version,
  };
  require("fs").writeFileSync(process.argv[3], JSON.stringify(out, null, 2));
' "$RELEASE_JSON" "$ENGINE_REV" "$FLUTTER_ROOT_DIR/bin/cache/flutter.version.json"

flutter --version
flutter pub get
flutter build web --release
