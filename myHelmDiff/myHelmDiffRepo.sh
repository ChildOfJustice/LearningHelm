#!/bin/bash

# Name of the release
RELEASE_NAME=$1

# Name of the chart
CHART_NAME=$2

# Repository URL
REPO_URL=$3

# Namespace
NAMESPACE=$4

# Value files
VALUES_FILES=$5


LATEST_REVISION=$(helm history $RELEASE_NAME --namespace $NAMESPACE -o json | jq 'sort_by(.revision) | reverse | .[0].revision')

# Get manifeest for the latest revision
helm get manifest $RELEASE_NAME --revision $LATEST_REVISION --namespace $NAMESPACE > /tmp/manifest-$LATEST_REVISION.yaml

# Get the manifest for the dry-run
helm template $RELEASE_NAME $CHART_NAME --repo $REPO_URL --namespace $NAMESPACE $VALUES_FILES > /tmp/manifest-dry-run.yaml

idea diff /tmp/manifest-$LATEST_REVISION.yaml /tmp/manifest-dry-run.yaml