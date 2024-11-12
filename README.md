```bash
uv run pytest                       # run tests
uv tool run ruff format             # format and lint
uv build                            # build wheel
uv run src/python-lambda/main.py    # run program
docker build . -t python-lambda     # build docker image
```

TODO - CDK init and deploy as lambda function
