#!/usr/bin/env bash
set -eo pipefail

# this script address
DIR=$(dirname "$0")

# stamp file
STAMP="${STAMP_PATH:?STAMP_PATH is not set}"/.stamp

# check stamp
if [ -e "$STAMP" ]; then
  echo "initialize has already completed."
  exit 0
fi

echo "========== DynamoDB =========="
# create dynamoDB tables
cp /scripts/test.json test.json
aws dynamodb create-table --endpoint-url "$DYNAMODB_ENDPOINT_URL" --cli-input-json file://test.json

# stamp
echo "initialized."
touch "$STAMP"