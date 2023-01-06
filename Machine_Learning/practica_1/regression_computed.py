import matplotlib.pyplot as plt
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error

from Machine_Learning.practica_1.dataset_generator import DatasetGenerator
from sklearn.linear_model import LinearRegression

if __name__ == '__main__':
    dataset = DatasetGenerator(dni='48778094').get_dataset()

    # Split the dataset into a training set and a test set
    train_set, test_set = train_test_split(dataset,
                                           train_size=200,
                                           random_state=48778094)
    # Describe the data
    train_set.info() # Podemos ver que tenemos 200 rows float not nulas
    train_set.describe()

    # Generating the histogram
    hist = train_set.hist()
    X_train = train_set.drop('target', axis=1)
    y_train = train_set[['target']]
    lm1 = LinearRegression()
    lm1.fit(X_train, y_train)

    X_test = train_set.drop('target', axis=1)
    y_test = train_set[['target']]
    y_pred_test = lm1.predict(X_test)
    error = mean_squared_error(y_test, y_pred_test)