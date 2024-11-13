import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from io import BytesIO
import base64

def render():
    plt.close("all")
    np.random.seed(123456)
    ts = pd.DataFrame(
        np.random.randn(1000, 4),
        index=pd.date_range("1/1/2023", periods=1000),
        columns=pd.Index(["A", "B", "C", "D"]),
    )
    ts = ts.cumsum()
    ts.plot()


    buffer = BytesIO()
    plt.savefig(buffer, format="png")
    return base64.b64encode(buffer.getvalue()).decode("utf-8")


if __name__ == "__main__":
    render()
