###############################################################################
##                                                                           ##
#                         Fichero con las funciones                           #
##                                                                           ##
###############################################################################


###############################################################################
##                              Import packages                              ##
###############################################################################

import numpy as np
import matplotlib.pyplot as plt
import math
from sympy import symbols, lambdify, pprint

###############################################################################
##                   Definicion de funciones  para ejercicios                ##
###############################################################################

# Seno
sin_vec  = np.vectorize(math.sin)

#Funcion de runge, no es necesario vectorizarla.
def runge_vec(x):
    value = 1/(1+25*x**2)
    return value



# Función exponencial
def exp_func(x):
    value = math.exp(-20*x**2)
    return value

exp_vec = np.vectorize(exp_func)


###############################################################################
##                   Definicion de funciones  auxiliares                     ##
###############################################################################
# Funcion para el método de las diferencias divididas.
def diferencias_divididas(xi, yi):
    """ Funcion que crea las diferencias divididas y devuelve el polinomio de Newton, junto a una funcion ejecutable.

    Args:
        xi:  Array de las equis
        yi: Array de los valores

    Returns:
        matriz: Devuelve una matriz con las diferencias divididas.
        pol: Devuelve el polinomio de Newton simbolico. Para verlo, se ha de usar pprint.
        pol_numpy: Funcion llamable y ejecutable para obtener valores.
    """
    # Inicializamos x como simbolico
    x = symbols('x')
    # Inicializamos una matriz de ceros
    n = len(yi)
    matriz = np.zeros([n, n])
    # El valor de la primera columna son los y
    matriz[:,0] = yi
    # Inicializo el polinomio en y0 y una variable auxiliar vx para los productos.
    pol = yi[0]
    vx  = 1
    # Recorremos de forma iterativa las columnas, siendo i las filas y j las columnas. 
    # Como la columna 0 es la de los yi, empezamos en 1. 
    # Como será una matriz triangular, a medida que avancemos en las columnas, recorreremos menos filas.
    # En cada iteración, calculo las diferencias por fila, y añado el resultado pertinente al polinomio
    for j in range(1,n):
        for i in range(n-j):
            matriz[i][j] = (matriz[i+1][j-1] - matriz[i][j-1]) / (xi[i+j]-xi[i])
       
        # vx serán los productos (x-x0), (x-x0)*(x-x1)...
        # Luego multiplico la diferencia dividida
        vx = vx*(x-xi[j-1])
        pol = pol+matriz[0][j]*vx
    pol_numpy = lambdify(x, pol, 'numpy')
    return matriz, pol, pol_numpy
