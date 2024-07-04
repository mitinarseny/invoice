#!/bin/sh -e
cd "$(dirname "$0")"

CONFIG="$1"
CONFIG="${CONFIG:-./invoice.yaml}"
shift || true
OUTPUT="${CONFIG%.*}.pdf"

set -x
typst compile ./invoice.typ \
  --input config="${CONFIG}" \
  "${OUTPUT}" \
  $*