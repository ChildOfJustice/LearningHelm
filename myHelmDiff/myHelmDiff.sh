#!/bin/bash

# Name of the release
RELEASE_NAME=$1

# Path to the chart
CHART_PATH=$2

# Value files
VALUES_FILES=$3

# Namespace
NAMESPACE=$4

# Check if NAMESPACE is empty
if [ -z "$NAMESPACE" ]
then
  NAMESPACE="default"
fi


LATEST_REVISION=$(helm history $RELEASE_NAME --namespace $NAMESPACE -o json | jq 'sort_by(.revision) | reverse | .[0].revision')

# Get manifest for the latest revision
helm get manifest $RELEASE_NAME --revision $LATEST_REVISION --namespace $NAMESPACE > /tmp/manifest-$LATEST_REVISION.yaml

# Get the manifest for the dry-run
helm template $RELEASE_NAME $CHART_PATH --namespace $NAMESPACE $VALUES_FILES > /tmp/manifest-dry-run.yaml


idea diff /tmp/manifest-$LATEST_REVISION.yaml /tmp/manifest-dry-run.yaml