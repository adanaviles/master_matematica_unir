import numpy as np
import pandas as pd
import seaborn as sns
import statsmodels.api as sm

from sklearn.feature_selection import SequentialFeatureSelector
from sklearn.linear_model import ElasticNet, ElasticNetCV, LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import (train_test_split, GridSearchCV, RepeatedKFold)
from sklearn.preprocessing import StandardScaler

from Machine_Learning.practica_1.dataset_generator import DatasetGenerator

if __name__ == '__main__':
    dataset = DatasetGenerator(dni='48778094').get_dataset()
    dataset_features = dataset.drop('target', axis=1)
    target = dataset[['target']]
    # Split the dataset into a training set and a test set
    X_train, X_test, y_train, y_test = train_test_split(dataset_features,
                                                        target,
                                                        train_size=200,
                                                        random_state=48778094)
    df_train = X_train.copy()
    df_train['target'] = y_train

    # Describe the data
    X_train.info()  # Podemos ver que tenemos 200 rows float not nulas
    X_train.describe()

    # Generating the histogram
    # plt.figure(figsize=(8, 8))
    # plt.hist(df_train, bins=5)
    # plt.show()


    # Regresion lineal simple
    lm_simple = LinearRegression()
    lm_simple.fit(X_train, y_train)
    # cargar funciones-----------------------------------------------

    # definir matriz de disenyo y variable respuesta-----------------
    X_train2 = sm.add_constant(X_train)
    # ajustar el modelo----------------------------------------------
    est = sm.OLS(y_train, X_train2) #Ordinary Least Squares
    # ver ajuste-----------------------------------------------------
    est2 = est.fit()
    print(est2.summary())
    #


    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)

    #Stepwise algorithm

    sfs = SequentialFeatureSelector(LinearRegression(),
                                    n_features_to_select=14)
    sfs.fit_transform(X_train2, y_train)
    final_features = sfs.get_feature_names_out()
    # Podemos ahora quedarnos con estas featuers y comprobar con ols otra vez
    est_stepwise = sm.OLS(y_train, X_train[sfs.get_feature_names_out()]) #Ordinary Least Squares
    # ver ajuste-----------------------------------------------------
    est_stepwise_2 = est_stepwise.fit()
    print(est_stepwise_2.summary())

    ## Elastic search
    # semilla para que los resultados sean los mismos----------------
    np.random.seed(48778094)
    # importar clase-------------------------------------------------


    # ajustar el modelo----------------------------------------------
    e_net = ElasticNetCV(cv=10,
                         l1_ratio=0.1)
    e_net.fit(X_train.to_numpy(), y_train.values.ravel())

    e_net2 = ElasticNetCV(cv=10,
                         l1_ratio=0.95)
    e_net2.fit(X_train.to_numpy(), y_train.values.ravel())

    e_net3 = ElasticNetCV(cv=10,
                         l1_ratio=0.5)
    e_net3.fit(X_train.to_numpy(), y_train.values.ravel())
    # Optimal alfa and r
    # define model evaluation method
    model = ElasticNet()
    # define model evaluation method
    cv = RepeatedKFold(n_splits=10, n_repeats=3, random_state=48778094)
    # define grid
    grid = dict()
    grid['alpha'] = [1e-5, 1e-3, 1e-1, 0.0, 1.0, 2.0, 3.0, 10.0, 100.0]
    grid['l1_ratio'] = np.arange(0, 1, 0.01)
    # define search
    search = GridSearchCV(model,
                          grid,
                          cv=cv,
                          scoring='neg_mean_squared_error',
                          n_jobs=-1)
    # perform the search
    results = search.fit(X_train2, y_train)

    print(f'MSE: {results.best_score_}')
    print(f'Parametros: {results.best_params_}')

    ## Comparativa de modelos
    # Caso 1

    # Añadimos el inercept al est2 para que funcione
    X_test2 = sm.add_constant(X_test)
    y_predict_ols = est2.predict(X_test2)

    print(f'MSE for OLS: {mean_squared_error(y_test, y_predict_ols)}')

    # Caso 2
    # Nos quedamos con las variables necesarias
    X_test_caso2 = X_test2[sfs.get_feature_names_out()]
    y_predict_ols_step = est_stepwise_2.predict(X_test_caso2)
    print(f'MSE for OLS: {mean_squared_error(y_test, y_predict_ols_step)}')

    # Caso 3
    y_predict_stepwise = results.predict(X_test)
    print(f'MSE for OLS: {mean_squared_error(y_test, y_predict_stepwise)}')

    ## Best modl prediction
    sfs = SequentialFeatureSelector(LinearRegression(),
                                    n_features_to_select=14)
    sfs.fit_transform(X_train, y_train)
    final_features = sfs.get_feature_names_out()
    # Podemos ahora quedarnos con estas featuers y comprobar con ols otra vez
    model = ElasticNet()
    # define model evaluation method
    cv = RepeatedKFold(n_splits=10, n_repeats=3, random_state=48778094)
    # define grid
    grid = dict()
    grid['alpha'] = [1e-5, 1e-3, 1e-1, 0.0, 1.0, 2.0, 3.0, 10.0, 100.0]
    grid['l1_ratio'] = np.arange(0, 1, 0.01)
    # define search
    search = GridSearchCV(model,
                          grid,
                          cv=cv,
                          scoring='neg_mean_squared_error',
                          n_jobs=-1)
    # perform the search
    results = search.fit(X_train[final_features], y_train)
    y_predict_stepwise_opt = results.predict(X_test[final_features])
    print(f'MSE for OLS: {mean_squared_error(y_test, y_predict_stepwise)}')
