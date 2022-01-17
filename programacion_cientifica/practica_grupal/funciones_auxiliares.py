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

#Funcion de runge
def runge_func(x):
    value = 1/(1+25*x**2)
    return value

runge_vec = np.vectorize(runge_func)

# Función exponencial
def exp_func(x):
    value = math.exp(-20*x**2)
    return value

exp_vec = np.vectorize(exp_func)


###############################################################################
##                   Definicion de funciones  auxiliares                     ##
###############################################################################