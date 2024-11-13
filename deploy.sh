#!/bin/sh
set -e

# consider moving to make/just

PROJECT_ROOT=$(git rev-parse --show-toplevel)

cd $PROJECT_ROOT

cp Dockerfile infra/.build/ecr/Dockerfile
cp .dockerignore infra/.build/ecr/.dockerignore
cp pyproject.toml infra/.build/ecr/pyproject.toml
cp uv.lock infra/.build/ecr/uv.lock
cp -r src/ infra/.build/ecr/src

cd $PROJECT_ROOT/infra
npx cdk deploy
