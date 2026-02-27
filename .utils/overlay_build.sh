#!/usr/bin/env bash
# overlay_build.sh - Build a thin overlay image on top of an existing container.
#
# Usage:
#   overlay_build.sh <language> [language2 ...]
#
# Resolution order for base image:
#   1. 100hellos/<lang>:local  (if exists locally)
#   2. 100hellos/<lang>:latest (if exists locally)
#   3. Pull 100hellos/<lang>:latest from registry
#
# The overlay copies files/ into /hello-world/ and fraglet/ into /
# on top of the base, picking up hello-world.sh, source files,
# fraglet.yml, and guide.md changes without a full rebuild.
# Tags result as 100hellos/<lang>:local.
#
# Caveat: Source changes compiled at Docker build time (RUN gcc ...) are NOT
# picked up — those require a full rebuild. This is suitable for runtime
# changes (hello-world.sh, fraglet.yml, marker adjustments).

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/.."

resolve_base_image() {
  local lang="$1"
  local image="100hellos/$lang"

  if docker image inspect "${image}:local" >/dev/null 2>&1; then
    echo "${image}:local"
    return
  fi

  if docker image inspect "${image}:latest" >/dev/null 2>&1; then
    echo "${image}:latest"
    return
  fi

  echo "Pulling ${image}:latest ..." >&2
  docker pull --platform linux/amd64 "${image}:latest" >&2
  echo "${image}:latest"
}

overlay_build() {
  local lang="$1"
  local base_image
  base_image=$(resolve_base_image "$lang")

  docker build --platform linux/amd64 \
    --build-arg BASE_IMAGE="$base_image" \
    -t "100hellos/$lang:local" \
    -f - "$lang/" <<'DOCKERFILE'
ARG BASE_IMAGE
FROM ${BASE_IMAGE}
COPY --chown=human:human ./files /hello-world
COPY --chown=human:human ./fraglet /
DOCKERFILE

  echo "✓ $lang overlay built (base: $base_image)"
}

if [ $# -eq 0 ]; then
  echo "Usage: $0 <language> [language2 ...]" >&2
  exit 1
fi

for lang in "$@"; do
  overlay_build "$lang"
done
