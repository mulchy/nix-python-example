from python_lambda.plot import render

def handler(event, context):
    return {'image': render() }
