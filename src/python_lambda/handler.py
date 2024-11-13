from .main import plot

def handler(event, context):
    return {'image': plot() }
