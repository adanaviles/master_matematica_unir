import numpy as np
import pandas as pd
import seaborn as sns
import statsmodels.api as sm

from sklearn.feature_selection import SequentialFeatureSelector
from sklearn.linear_model import ElasticNet, ElasticNetCV, LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import (train_test_split, GridSearchCV, RepeatedKFold)
from sklearn.preprocessing import StandardScaler

from Machine_Learning.Practicas.practica_1.dataset_generator import DatasetGenerator

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
                          scoring='3',
                          n_jobs=-1)
    # perform the search
    results = search.fit(X_train[final_features], y_train)
    y_predict_stepwise_opt = results.predict(X_test[final_features])
    print(f'MSE for OLS: {mean_squared_error(y_test, y_predict_stepwise)}')


    # ## Ridge
    # # importar clase-------------------------------------------------
    # from sklearn.linear_model import Ridge
    #
    # # ajustar el modelo----------------------------------------------
    # ridge_reg = Ridge(alpha=1, solver="auto")
    # ridge_reg.fit(X_train[final_features], y_train)
    # # obtener coeficientes del modelo--------------------------------
    # # intercepto
    # # importar clase-------------------------------------------------
    # from sklearn.linear_model import Ridge
    #
    # # ajustar el modelo----------------------------------------------
    # ridge_reg_b = Ridge(alpha=1e4, solver="auto")
    # ridge_reg.fit(X_train[final_features], y_train)
    #
    # # importar clase-------------------------------------------------
    # from sklearn.linear_model import Lasso
    #
    # # ajustar el modelo----------------------------------------------
    # lasso_reg = Lasso(alpha=1)
    # lasso_reg.fit(housing_prepared, respuesta)
    # # obtener coeficientes del modelo--------------------------------
    # # intercepto
    #
    # fig = plt.figure(figsize=(8, 8))
    # # ancho de barra-------------------------------------------------
    # barWidth = 0.25
    # # definir posicion barras series---------------------------------
    # r1 = np.arange(len(lm1.coef_))
    # r2 = [x + barWidth for x in r1]
    # r3 = [x + barWidth for x in r2]
    # # pintar las barras----------------------------------------------
    # plt.bar(r1, lm1.coef_, color="blue",
    #         width=barWidth, edgecolor="white", label="Lineal");
    # plt.bar(r2, ridge_reg_b.coef_, color="red",
    #         width=barWidth, edgecolor="white", label="Ridge b");
    # plt.bar(r3, lasso_reg_b.coef_, color="green",
    #         width=barWidth, edgecolor="white", label="Lasso b");
    # plt.xticks([r + barWidth for r in range(len(lm1.coef_))],
    #            ['B1', 'B2', 'B3', 'B4',
    #             'B5', 'B6', 'B7', 'B8',
    #             'B9', 'B10', 'B11', 'B12']);
    # plt.legend();
    # plt.xlabel("Variable");
    # plt.ylabel("Beta");
    # plt.show()


# >>> from sklearn.metrics import r2_score
# >>> y_true = [3, -0.5, 2, 7]
# >>> y_pred = [2.5, 0.0, 2, 8]
# >>> r2_score(y_true, y_pred)

# >>> from sklearn.metrics import mean_squared_error
# >>> y_true = [3, -0.5, 2, 7]
# >>> y_pred = [2.5, 0.0, 2, 8]
# >>> mean_squared_error(y_true, y_pred)
# 0.375


# Adj r2 = 1-(1-R2)*(n-1)/(n-p-1) Where n is the sample size and p is the number of independent variables.

#List of error regression

# See the Regression metrics section of the user guide for further details.
#
# metrics.explained_variance_score(y_true, ...)
#
# Explained variance regression score function.
#
# metrics.max_error(y_true, y_pred)
#
# The max_error metric calculates the maximum residual error.
#
# metrics.mean_absolute_error(y_true, y_pred, *)
#
# Mean absolute error regression loss.
#
# metrics.mean_squared_error(y_true, y_pred, *)
#
# Mean squared error regression loss.
#
# metrics.mean_squared_log_error(y_true, y_pred, *)
#
# Mean squared logarithmic error regression loss.
#
# metrics.median_absolute_error(y_true, y_pred, *)
#
# Median absolute error regression loss.
#
# metrics.mean_absolute_percentage_error(...)
#
# Mean absolute percentage error (MAPE) regression loss.
#
# metrics.r2_score(y_true, y_pred, *[, ...])
#
#  (coefficient of determination) regression score function.
#
# metrics.mean_poisson_deviance(y_true, y_pred, *)
#
# Mean Poisson deviance regression loss.
#
# metrics.mean_gamma_deviance(y_true, y_pred, *)
#
# Mean Gamma deviance regression loss.
#
# metrics.mean_tweedie_deviance(y_true, y_pred, *)
#
# Mean Tweedie deviance regression loss.
#
# metrics.d2_tweedie_score(y_true, y_pred, *)
#
# D^2 regression score function, fraction of Tweedie deviance explained.
#
# metrics.mean_pinball_loss(y_true, y_pred, *)
#
# Pinball loss for quantile regression.
#
# metrics.d2_pinball_score(y_true, y_pred, *)
#
#  regression score function, fraction of pinball loss explained.
#
# metrics.d2_absolute_error_score(y_true, ...)
#
#  regression score function, fraction of absolute error explained.




# Choosing between R-squared (R2), adjusted R-squared (R2 adjusted), and mean squared error (MSE) depends on the specific goals and context of your regression analysis or predictive modeling task. Each metric serves a different purpose and has its advantages and limitations. Here's a guide on when to use each of these metrics:
#
# R-squared (R2):
#
# Purpose: R2 measures the proportion of the variance in the dependent variable (target) that is explained by the independent variables (features) in your regression model. It assesses the goodness of fit of your model.
#
# Use when:
#
# You want to understand how well your model fits the data.
# You need an easily interpretable metric for model performance.
# You're comparing multiple models and need a quick assessment of their fit.
# Limitations:
#
# R2 does not penalize model complexity, so it may overestimate the model's performance when additional predictors are added.
# It does not provide information about the absolute errors or the direction of errors.
# Adjusted R-squared (R2 adjusted):
#
# Purpose: Adjusted R2 is a modification of R2 that takes into account the number of predictors in the model. It penalizes the inclusion of irrelevant or redundant variables and encourages simplicity.
# Use when:
# You want to assess model fit while considering model complexity.
# You need to compare models with different numbers of predictors.
# Limitations:
# Like R2, it doesn't provide information about the direction or magnitude of errors.
# It may not always be appropriate in situations where model simplicity is not a primary concern.
# Mean Squared Error (MSE):
#
# Purpose: MSE measures the average squared difference between the predicted values and the actual values in a regression or predictive modeling task. It quantifies the magnitude of prediction errors.
# Use when:
# You want to evaluate the accuracy of your predictive model in terms of absolute error.
# You need a metric that penalizes both overestimations and underestimations of the target variable.
# Limitations:
# It doesn't provide a measure of the model's explanatory power or fit to the data.
# MSE is sensitive to outliers, as it squares errors.
# In summary, the choice of metric depends on your goals:
#
# Use R2 or adjusted R2 when you want to assess the goodness of fit and model simplicity.
# Use MSE when you want to quantify prediction accuracy and are less concerned with model fit.
# In practice, it's often a good idea to consider multiple metrics to gain a comprehensive understanding of your model's performance. For example, you can use R2 or adjusted R2 to assess model fit and MSE to evaluate prediction accuracy simultaneously. Additionally, consider the specific requirements of your problem and the trade-offs between model complexity and performance.



#
# When comparing linear models, it's important to consider various criteria beyond just R-squared, adjusted R-squared, and mean squared error (MSE). Here are some additional criteria and techniques to help you make a comprehensive assessment:
#
# Root Mean Squared Error (RMSE): RMSE is the square root of MSE and provides a more interpretable measure of error in the same units as the target variable. It's particularly useful when you want to communicate the magnitude of prediction errors.
#
# Residual Analysis: Visual examination of residual plots can be very informative. Check for patterns in residuals (e.g., heteroscedasticity, non-linearity) to identify potential model deficiencies.
#
# AIC (Akaike Information Criterion) and BIC (Bayesian Information Criterion): These are information criteria that balance model fit and complexity. Lower values indicate better models. AIC is more suitable when comparing models fitted on the same data, while BIC is often preferred when selecting models among different datasets.
#
# Cross-Validation: Use techniques like k-fold cross-validation to estimate the model's out-of-sample performance. This helps assess how well the model generalizes to new data.
#
# Prediction Intervals: Instead of just point predictions, consider prediction intervals that provide a range of values where the true response is likely to fall. This gives a measure of prediction uncertainty.
#
# Feature Importance: If you have multiple predictors, analyze feature importance scores (e.g., coefficients, variable importance in random forests) to understand which variables contribute the most to the model's predictions.
#
# Model Assumptions: Ensure that the assumptions of linear regression are met, including linearity, independence of errors, constant variance (homoscedasticity), and normally distributed errors. Deviations from these assumptions may affect model performance.
#
# Outlier Analysis: Identify and investigate potential outliers that may be skewing the results or affecting model assumptions. You can use techniques like residual analysis, Cook's distance, or leverage plots to identify outliers.
#
# Collinearity: Check for multicollinearity among predictor variables. High correlations between predictors can lead to unstable coefficient estimates. Consider methods like variance inflation factor (VIF) to assess collinearity.
#
# Adjusted R-squared per Predictor: Evaluate how much each predictor contributes to model performance by considering adjusted R-squared values as predictors are added or removed.
#
# Comparing Model Variants: If you have multiple versions of the same model (e.g., with different subsets of predictors or transformations), use cross-validation or information criteria to select the best-performing variant.
#
# Domain Knowledge: Incorporate domain-specific knowledge and expert opinions into the model selection process. Sometimes, certain variables or model choices may make more sense given the context of the problem.
#
# Model Stability and Robustness: Assess how sensitive your model is to changes in the dataset. You can perform sensitivity analyses by introducing small perturbations to the data and observing the model's stability.



# import numpy as np
# import matplotlib.pyplot as plt
# from sklearn.datasets import make_classification
# from sklearn.model_selection import train_test_split
# from sklearn.linear_model import LogisticRegression
# from sklearn.metrics import roc_curve, roc_auc_score, auc
#
# # Generate synthetic data
# X, y = make_classification(n_samples=1000, n_features=20, random_state=42)
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
#
# # Train a logistic regression model (you can replace this with any other model)
# model = LogisticRegression(random_state=42)
# model.fit(X_train, y_train)
#
# # Predict probabilities for positive class (class 1)
# y_prob = model.predict_proba(X_test)[:, 1]
#
# # Calculate ROC curve
# fpr, tpr, thresholds = roc_curve(y_test, y_prob)
#
# # Calculate AUC (Area Under the Curve)
# roc_auc = auc(fpr, tpr)
#
# # Plot ROC curve
# plt.figure(figsize=(8, 6))
# plt.plot(fpr, tpr, color='darkorange', lw=2, label='ROC curve (area = {:.2f})'.format(roc_auc))
# plt.plot([0, 1], [0, 1], color='navy', lw=2, linestyle='--')
# plt.xlim([0.0, 1.0])
# plt.ylim([0.0, 1.05])
# plt.xlabel('False Positive Rate')
# plt.ylabel('True Positive Rate')
# plt.title('Receiver Operating Characteristic (ROC) Curve')
# plt.legend(loc='lower right')
plt.show()