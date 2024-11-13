```bash
uv run pytest                       # run tests
uv tool run ruff format             # format and lint (runs automatically on commit)
uv build                            # build wheel (this is mostly to check that is possible, not needed for lambda)

uv run src/python-lambda/plot.py    # run program
uv run app                          # same thing but defined as a project script

docker build --platform linux/arm64 -t python-lambda .      # build AWS Lambda compatible docker image

./deploy.sh                         # deploy to AWS Lambda

# test it out
aws lambda invoke \
  --function-name "arn:aws:lambda:us-west-2:070361786815:function:InfraStack-MyFunction3BAA72D1-O5YvCVSWhFrt" \
  --payload '{}' \
  /dev/stdout | jq -r '.image' | base64 --decode > image.png && open image.png
```
