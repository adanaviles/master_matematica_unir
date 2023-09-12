from sklearn.datasets import make_classification
from sklearn.linear_model import LogisticRegression
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, roc_auc_score
from sklearn.ensemble import (GradientBoostingClassifier)
import pandas as pd
from sklearn.model_selection import (train_test_split, GridSearchCV, RepeatedKFold)


class DatasetGenerator:
    def __init__(self,
                 fecha: str = '28/08/1997'):
        """
        fecha es una string de fecha, espera el formato dd/mm/yyyy
        Args:
            fecha:
        """
        self.fecha = fecha
        self.__check_format()
        
    def __check_format(self):
        """ Checkea el formato de fecha
        """
        if not isinstance(self.fecha, str):
            raise TypeError('fecha no es una string')
        if len(self.fecha.split('/')) != 3:
            raise TypeError('fecha no tiene 3 componentes separados por /')
    
    def _get_d_m_s_s1(self):
        d = self.fecha.split('/')[0]
        m = self.fecha.split('/')[1]
        s1 = int(d[0]) + int(d[1])
        s2 = int(m[0]) + int(m[1])
        s = max(s1, s2)
        return int(d), int(m), s, s1

    def create_dataset(self) -> pd.DataFrame:
        d, m, s, s1 = self._get_d_m_s_s1()
        # Si mntngo las diectrices del examen me aparec que
        # ValueError: Number of informative, redundant and repeated
        # features must sum to less than the number of total features
        try:
            X, y = make_classification(n_samples=200+m*10,
                                       n_features=10+s,
                                       n_informative=10+s1, # Es s1
                                       n_redundant=2,
                                       n_repeated=0,
                                       n_classes=2,
                                       random_state=0)
        except ValueError:
            X, y = make_classification(n_samples=200+m*10,
                                       n_features=10+s+3,
                                       n_informative=10+s1, # Es s1
                                       n_redundant=2,
                                       n_repeated=0,
                                       n_classes=2,
                                       random_state=0)
        list_of_features = [
            f'feature_{number}' for number in range(0, X.shape[1])
        ]
        dataset = pd.DataFrame(X, columns=list_of_features)
        dataset['target'] = y
        return dataset

if __name__ == '__main__':

    # Generamos el dataset
    dg = DatasetGenerator(fecha='28/08/1997')
    dataset = dg.create_dataset()

    # Tendremos por un lado las features y por otro el target
    dataset_features = dataset.drop('target', axis=1)
    target = dataset[['target']]
    # Separamos el dataset en train y test
    X_train, X_test, y_train, y_test = train_test_split(dataset_features,
                                                        target,
                                                        train_size=0.8,
                                                        random_state=28081997)
    df_train = X_train.copy()
    df_train['target'] = y_train

    # Describimos los datos
    X_train.info()
    # Tenemos 224 filas para cada feature, todas de ellas no nulas
    # No debemos entonces imputar ningun dato, lo cual facilita el estudio
    # en caso de tener missings, podríamos imputar con la media o la mediana.
    X_train.describe()
    # Describiendo el dataset podemos ver cómo todas las variables tienen un
    # máximo aproximado de  6-9 menos la variable 8 y la 15, que tienen outliers
    # tanto en el mínimo como en el máximo.
    # Generating the histogram
    df_train.hist(figsize=(16, 18))
    plt.show()
    # En el histograma podemos ver como el target solo tiene dos categorías,
    # Si hacemos la correlacion, podemos ver como se relacionan las variables
    # con el target y si algunas tienen relacion entre sí, o si son
    # combinaciones lineales de otras variables.
    correlation = df_train.corr()

    # Ejercicio 2 - Aplicar la regresión logísitca
    # No puedo ejecuar bien el programa, mi ordenador me está dando problemas
    # escribiré todo el código posible y daré todos los resultados posibles
    # explicados
    logistic_reg = LogisticRegression()
    logistic_reg.fit(X_train,
                     y_train.values.reshape(-1, 1).ravel())
    # logistic_reg.predict_proba(##Aqui iria la moda, no puedo calcularla)


    # Ejercicio 3, arbol de decision
    clf = DecisionTreeClassifier(random_state=28081997)
    clf = clf.fit(X_train, y_train)
    y_pred = clf.predict(X_test)
    print(f"acuracy arbol de decision {accuracy_score(y_test, y_pred)}")
    y_prob_pred = clf.predict_proba(X_test)[:, 1]
    print(f"ROC AUC Score arbol de decision {roc_auc_score(y_test, y_prob_pred)}")
    print("="*79)
    # Intentaría usar graphviz para plotear el arbol, pero no me está dejando
    # Al ejecutarlo, se bloquea mi terminal, creo que es debido al smowl
    # Pero en general, los resulatdos no son demasiado buenos. esto es debido
    # A que los arboles de decision sin parámetros tienden a sobreajustarse
    # demasiado a los datos de entrenamiento, haciendo que en la valiadcion
    # los resultados no sean los esperados. usando
    # clf.tree_.max_depth podemos ver que tenemos 10 de depth

    # from graphviz import Source
    # from sklearn.tree import export_graphviz
    #
    # export_graphviz(
    #     clf,
    #     feature_names=X_train.columns,
    #     rounded=True,
    #     filled=True
    # )


    # Ejercicio 4
    # Como restriccion incluiría max_depth, para que no sobreajuste demasiado
    clf3 = DecisionTreeClassifier(random_state=28081997,
                                  max_depth=3)
    clf3 = clf3.fit(X_train, y_train)
    y_pred = clf3.predict(X_test)
    print(f"acuracy arbol de decision max_depht=3 {accuracy_score(y_test, y_pred)}")
    y_prob_pred = clf3.predict_proba(X_test)[:, 1]
    print(f"ROC AUC Score arbol de decision max_depht=3 {roc_auc_score(y_test, y_prob_pred)}")
    print("="*79)
    # En este caso, incluso tras el ajuste, el resultado no es demasiado bueno
    # Podriamos probar más ajustes, o un GridSearch para encontrar la forma optima
    # Pero lo haremos en el gradient boosting

    # Ejercicio 5. Los modelos de gradient boosting mejoran los errores de los arboles
    # anteriores, haciendolos mucho más robustos a la par que dando mejores resultados.
    # usremos un kfold sumado a un gridsearch para enconrtar los mejores parametros
    # para el gradientboosting

    cv = RepeatedKFold(n_splits=10, n_repeats=3, random_state=28081997)
    # define grid
    grid = dict()
    grid['learning_rate'] = [1, 0.5, 0.25, 0.1, 0.05, 0.01]
    grid['max_depth'] = [1, 2, 3, 4]
    # define search
    gb_clf = GradientBoostingClassifier(random_state=28081997)
    # Buscamos el que maximice la accuracy (no necesariamente tenemos que
    #  score)
    search = GridSearchCV(gb_clf,
                          grid,
                          cv=cv,
                          scoring='accuracy',
                          n_jobs=-1)
    # perform the search
    results = search.fit(X_train, y_train.values.reshape(-1, 1).ravel())


    print(f'Accuracy: {results.best_score_}')
    print(f'Parametros: {results.best_params_}')

    # Ejercicio 6:
    # Con una accuracy de 0.81 considero que el GradientBoosting junto al gridsearch
    # es el que mejor se adapta. No solo porque evita el sobreajuste,si no porque
    # nos ofrece un modelo más robusto y resistente al covariateshift, donde
    # si los datos cambian con el tiempo, el modelo seguiria funcionando (aunque siempre habria que
    # reentrenarlo  en algun momento. Si no me fuera mal el ordenador, haría
    # una comparación más exhaustiva, teniendo en cuenta no  solo los resultados
    # sino el gasto computacional que requieren y diferentes scores.
    # Tambien tener en cuenta que el arbol de decision inicial será el que mejor
    # resultado de si intenta predecir un dato que ya ha visto en el train, debido
    # a su sobreajuste.
