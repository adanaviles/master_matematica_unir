###############################################################################
##                                                                           ##
#                         Fichero con las constantes                          #
##                                                                           ##
###############################################################################


###############################################################################
##                              Import packages                              ##
###############################################################################

import numpy as np
from math import pi
from numpy.polynomial import chebyshev

###############################################################################
##                     Creación de nodos y abscisas                          ##
###############################################################################
# Podriamos usar para los nodos np.arange, pero en la documentación oficial recomiendan utilizar linspace si los setps no son enteros
######## Seno
abscisas_sin = np.linspace(-pi, pi, 100)
nodos_sin_11 = np.linspace(-pi,pi,11) 
nodos_sin_21 = np.linspace(-pi,pi,21) 

######## Runge
abscisas_runge = np.linspace(-1, 1, 100)
nodos_runge_11 = np.linspace(-1,1,11) 
nodos_runge_21 = np.linspace(-1,1,21) 

######## Gauss
abscisas_gauss = np.linspace(-1, 1, 100)
nodos_gauss_11 = np.linspace(-1,1,11) 
nodos_gauss_21 = np.linspace(-1,1,21) 

###############################################################################
##                     Creación de nodos de Chebyshev                        ##
###############################################################################
#Nodos de Chebyshev
# Tomamos el polinomio T_11(x).  Hemos de poner los coeficientes en orden ascendente, es decir,  
# (1, 0, 3) devolvería 1*T_0(x) + 2*T_1(x) + 3*T_2(x).
coefs_Cheby_11 = [0]*11+[1]
coefs_Cheby_21 = [0]*21+[1]

######## Seno
T11_sin = chebyshev.Chebyshev(coefs_Cheby_11, [-pi, pi])
nodos_cheby_sin_11 = T11_sin.roots()
T21_sin = chebyshev.Chebyshev(coefs_Cheby_21, [-pi, pi])
nodos_cheby_sin_21 = T21_sin.roots()

######## Runge
T11_runge = chebyshev.Chebyshev(coefs_Cheby_11, [-1, 1])
nodos_cheby_runge_11 = T11_runge.roots()
T21_runge = chebyshev.Chebyshev(coefs_Cheby_21, [-1, 1])
nodos_cheby_runge_21 = T21_runge.roots()

######## Gauss
T11_gauss = chebyshev.Chebyshev(coefs_Cheby_11, [-1, 1])
nodos_cheby_gauss_11 = T11_gauss.roots()
T21_gauss = chebyshev.Chebyshev(coefs_Cheby_21, [-1, 1])
nodos_cheby_gauss_21 = T21_gauss.roots()