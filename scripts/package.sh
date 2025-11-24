#!/usr/bin/env bash
set -euo pipefail

TMPDIR="$(mktemp -d)"

cp buildpack.toml "${TMPDIR}/buildpack.toml"
cp -r bin "${TMPDIR}/bin"
cp LICENSE "${TMPDIR}/LICENSE"
pushd "${TMPDIR}/"

if [[ -z "${GITHUB_OUTPUT:-}" ]]; then
    echo "Packaging buildpack locally..."
    REPO="docker.io/local/apt"
else
    echo "Packaging and publishing buildpack..."
fi

BP_ID="$(cat buildpack.toml | yj -t | jq -r .buildpack.id)"
VERSION="$(cat buildpack.toml | yj -t | jq -r .buildpack.version)"
PACKAGE="${REPO}/$(echo "$BP_ID" | sed 's/\//_/g')"

echo "Building ${PACKAGE}:${VERSION}"
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
    pack buildpack package --publish "${PACKAGE}:${VERSION}"
    DIGEST="$(crane digest "${PACKAGE}:${VERSION}")"

    echo "bp_id=$BP_ID" >> "$GITHUB_OUTPUT"
    echo "version=$VERSION" >> "$GITHUB_OUTPUT"
    echo "address=${PACKAGE}@${DIGEST}" >> "$GITHUB_OUTPUT"
else
    pack buildpack package "${PACKAGE}:${VERSION}"
fi

popd > /dev/null
