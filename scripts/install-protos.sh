#!/usr/bin/env bash
set -o pipefail

export ID_TOKEN=$(gcloud auth print-identity-token)
export GO_GAR_LOCATION=https://us-east1-go.pkg.dev/shankiyani-dev-d736c9/go-protos
export PROTOS_GO_MODULE=github.com/kiyani-org/proto-solution

export GOPROXY=$GO_GAR_LOCATION,https://proxy.golang.org,direct
export GONOSUMDB=$PROTOS_GO_MODULE
export GONOPROXY=github.com/GoogleCloudPlatform/artifact-registry-go-tools

echo "running go run add-location"
GOPROXY=proxy.golang.org \
go run github.com/GoogleCloudPlatform/artifact-registry-go-tools/cmd/auth@latest \
  add-locations --locations=us-east1

echo "running go run refresh"
GOPROXY=proxy.golang.org \
go run github.com/GoogleCloudPlatform/artifact-registry-go-tools/cmd/auth@latest refresh  

echo "running go mod tidy"
go mod tidy
