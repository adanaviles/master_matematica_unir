import numpy as np
import matplotlib.pyplot as plt

from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, roc_auc_score
from sklearn.ensemble import (BaggingClassifier, RandomForestClassifier,
GradientBoostingClassifier)
from sklearn.model_selection import (train_test_split )

from Machine_Learning.practica_2.dataset_generator import DatasetGenerator

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
    df_train.hist(figsize=(16, 18))
    plt.show()


    # Clasificacion por arboles de decision
    ##exportar figuras tambien
    clf = DecisionTreeClassifier(random_state=48778094)
    clf = clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    print(accuracy_score(y_test, y_pred))
    # roc auc
    # predict_proba produce la probabilidad de caer en una clase u otra
    # si tengo 2 clases, tendre dos columnas con la probabilidad de que
    # esa fila caiga en esa clase
    y_prob_pred = clf.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))

    #cambiando parametros
    clf3 = DecisionTreeClassifier(random_state=48778094, max_depth=3)
    clf3 = clf3.fit(X_train, y_train)
    y_pred = clf3.predict(X_test)
    print(accuracy_score(y_test, y_pred))
    y_prob_pred = clf3.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))
    # Clasificacion por bagging
    bag_clf = BaggingClassifier(
        DecisionTreeClassifier(random_state=48778094),
        bootstrap=True)
    # ajustar el modelo----------------------------------------------
    bag_clf = bag_clf.fit(X_train, y_train)
    y_prob_pred = bag_clf.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))

    #Clasificacion por pasting

    past_clf = BaggingClassifier(
        DecisionTreeClassifier(random_state=48778094),
        bootstrap=False)
    # ajustar el modelo----------------------------------------------
    past_clf = past_clf.fit(X_train, y_train)
    y_prob_pred = past_clf.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))


    #Clasificacion por random forest

    # crear objeto de la clase RandomForestClassifier----------------
    rnd_clf = RandomForestClassifier(max_leaf_nodes=4,
                                     random_state=48778094,)
    # ajustar el modelo----------------------------------------------
    rnd_clf = rnd_clf.fit(X_train, y_train)
    y_prob_pred = rnd_clf.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))
    # GBM
# cargar librerias-----------------------------------------------
    gb_clf = GradientBoostingClassifier(random_state=48778094)
    gb_clf = gb_clf.fit(X_train, y_train)
    y_prob_pred = gb_clf.predict_proba(X_test)[:, 1]
    print(roc_auc_score(y_test, y_prob_pred))
    #meter tambien xgboost

    ### feature importance
    importancias_clf = clf.feature_importances_
    indices_clf = np.argsort(importancias_clf)[::-1]

    importancias_clf3 = clf3.feature_importances_
    indices_clf3 = np.argsort(importancias_clf3)[::-1]

    importancias_bag_clf = np.mean([
        tree.feature_importances_ for tree in bag_clf.estimators_
    ], axis=0)
    indices_bag_clf = np.argsort(importancias_bag_clf)[::-1]

    importancias_past_clf=  np.mean([
        tree.feature_importances_ for tree in past_clf.estimators_
    ], axis=0)
    indices_past_clf = np.argsort(importancias_past_clf)[::-1]

    importancias_rnd_clf = rnd_clf.feature_importances_
    indices_rnd_clf = np.argsort(importancias_rnd_clf)[::-1]

    importancias_gb_clf = gb_clf.feature_importances_
    indices_gb_clf = np.argsort(importancias_gb_clf)[::-1]

    plt.figure(figsize=(12, 13))
    plt.subplot(6, 1, 1)
    plt.title("Importancia de las variables Arbol Decision")
    plt.bar(range(X_train.shape[1]), importancias_clf[indices_clf],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_clf)
    plt.xlim([-1, X_train.shape[1]])

    plt.subplot(6, 1, 2)
    plt.title("Importancia de las variables Arbol Decision depth3")
    plt.bar(range(X_train.shape[1]), importancias_clf3[indices_clf3],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_clf3)
    plt.xlim([-1, X_train.shape[1]])

    plt.subplot(6, 1, 3)
    plt.title("Importancia de las variables Bagging")
    plt.bar(range(X_train.shape[1]), importancias_bag_clf[indices_bag_clf],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_bag_clf)
    plt.xlim([-1, X_train.shape[1]])

    plt.subplot(6, 1, 4)
    plt.title("Importancia de las variables Pasting")
    plt.bar(range(X_train.shape[1]), importancias_past_clf[indices_past_clf],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_past_clf)
    plt.xlim([-1, X_train.shape[1]])

    plt.subplot(6, 1, 5)
    plt.title("Importancia de las variables RandomForest")
    plt.bar(range(X_train.shape[1]), importancias_rnd_clf[indices_rnd_clf],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_rnd_clf)
    plt.xlim([-1, X_train.shape[1]])

    plt.subplot(6, 1, 6)
    plt.title("Importancia de las variables GradientBoosting")
    plt.bar(range(X_train.shape[1]), importancias_gb_clf[indices_gb_clf],
            color="r", align="center")
    plt.xticks(range(X_train.shape[1]), indices_gb_clf)
    plt.xlim([-1, X_train.shape[1]])