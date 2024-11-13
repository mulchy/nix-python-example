#### adapted from https://hynek.me/articles/docker-uv/

# syntax=docker/dockerfile:1.9
FROM public.ecr.aws/lambda/python:3.12 AS build

COPY --from=ghcr.io/astral-sh/uv:0.4.30 /uv /usr/local/bin/uv

# - Silence uv complaining about not being able to use hard links,
# - tell uv to byte-compile packages for faster application startups,
# - prevent uv from accidentally downloading isolated Python builds,
ENV UV_LINK_MODE=copy \
  UV_COMPILE_BYTECODE=1 \
  UV_PYTHON_DOWNLOADS=never

COPY pyproject.toml .
COPY uv.lock .

RUN --mount=type=cache,target=/root/.cache \
  uv export \
  --no-emit-project \
  --frozen \
  > requirements.txt

RUN --mount=type=cache,target=/root/.cache \
  uv pip install \
  --system \
  -r requirements.txt

COPY . /src
RUN --mount=type=cache,target=/root/.cache \
  uv pip install \
  --system \
  --no-deps \
  /src

##########################################################################

FROM public.ecr.aws/lambda/python:3.12

# Copy the pre-built `/app` directory to the runtime container
COPY --from=build /var/lang/lib/python3.12/site-packages /var/lang/lib/python3.12/site-packages

# "two dot" format
CMD [ "python_lambda.lambda.handler" ]
