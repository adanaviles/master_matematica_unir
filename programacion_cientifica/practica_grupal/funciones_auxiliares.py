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
# Podemos usar sumpy para matemáticas simbólicas y devolver polinomio, lambdify.