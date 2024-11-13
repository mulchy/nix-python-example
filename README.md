```bash
uv run pytest                       # run tests
uv tool run ruff format             # format and lint (runs automatically on commit)
uv build                            # build wheel (this is mostly to check that is possible, not needed for lambda)

uv run src/python-lambda/plot.py    # run program
uv run app                          # same thing but defined as a project script

docker build --platform linux/arm64 -t python-lambda .      # build AWS Lambda compatible docker image
```

TODO - CDK init and deploy as lambda function
