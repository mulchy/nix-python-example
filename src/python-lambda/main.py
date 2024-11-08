import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


def plot():
    plt.close("all")
    np.random.seed(123456)
    ts = pd.DataFrame(
        np.random.randn(1000, 4),
        index=pd.date_range("1/1/2023", periods=1000),
        columns=pd.Index(["A", "B", "C", "D"]),
    )
    ts = ts.cumsum()
    ts.plot()
    plt.show()


if __name__ == "__main__":
    plot()
