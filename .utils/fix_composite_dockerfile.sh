#!/usr/bin/env sh
#
# This script corrects the FROM statements in the generated Dockerfile.composite.
# It rewrites lines like:
#   FROM 100hellos/000-base:local AS o100hellos_050-c
# to:
#   FROM o100hellos_000-base AS o100hellos_050-c
#
# This is necessary because the CI environment does not have the local images
# and would otherwise try to pull them from Docker Hub.

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_dockerfile>"
  exit 1
fi

DOCKERFILE=$1
TAG_PATH_ROOT=${2:-100hellos}

# Using '|' as a separator for sed avoids issues with escaping slashes in paths.
# This command finds all lines that reference a local image from the project
# and rewrites them to use the correct multi-stage build alias.
sed -i "s|FROM ${TAG_PATH_ROOT}/\\([^:]*\\):local|FROM o${TAG_PATH_ROOT}_\\1|g" "${DOCKERFILE}"