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
import funciones_auxiliares as F


###############################################################################
##                     Creación de nodos y abscisas                          ##
###############################################################################
# Podriamos usar para los nodos np.arange, pero en la documentación oficial recomiendan utilizar linspace si los setps no son enteros

#################
##     Seno    ##
#################
# Para representar la función
abscisas_sin = np.linspace(-pi, pi, 100)
ordenadas_sin = F.sin_vec(abscisas_sin)

# Para los nodos de 11
nodos_sin_11 = np.linspace(-pi,pi,11) 
ordenadas_sin_11 = F.sin_vec(nodos_sin_11)

# Para los nodos de 21
nodos_sin_21 = np.linspace(-pi,pi,21) 
ordenadas_sin_21 = F.sin_vec(nodos_sin_21)

#################
##    Runge    ##
#################

# Para representar la función
abscisas_runge = np.linspace(-1, 1, 100)
ordenadas_runge = F.runge_vec(abscisas_runge)

# Para los nodos de 11
nodos_runge_11 = np.linspace(-1,1,11) 
ordenadas_runge_11  = F.runge_vec(nodos_runge_11)

# Para los nodos de 21
nodos_runge_21 = np.linspace(-1,1,21) 
ordenadas_runge_21  = F.runge_vec(nodos_runge_21)

#################
##    Gauss    ##
#################

# Para representar la función
abscisas_gauss = np.linspace(-1, 1, 100)
ordenadas_gauss = F.exp_vec(abscisas_gauss)

# Para los nodos de 11
nodos_gauss_11 = np.linspace(-1,1,11) 
ordenadas_gauss_11  = F.exp_vec(nodos_gauss_11)

# Para los nodos de 21
nodos_gauss_21 = np.linspace(-1,1,21) 
ordenadas_gauss_21  = F.exp_vec(nodos_gauss_21)


###############################################################################
##                     Creación de nodos de Chebyshev                        ##
###############################################################################
# Nodos de Chebyshev
# Usamos una función auxiliar para un código más limpio
#################
##     Seno    ##
#################
# Para los nodos de 11
nodos_cheby_sin_11, ordenadas_cheby_sin_11 = F.nodos_ordenadas_cheby(F.sin_vec,
                                                       11,
                                                       [-pi, pi])

# Para los nodos de 21
nodos_cheby_sin_21, ordenadas_cheby_sin_21 = F.nodos_ordenadas_cheby(F.sin_vec,
                                                       21,
                                                       [-pi, pi])

#################
##    Runge    ##
#################
# Para los nodos de 11
nodos_cheby_runge_11, ordenadas_cheby_runge_11 = F.nodos_ordenadas_cheby(F.runge_vec,
                                                       11,
                                                       [-1, 1])

# Para los nodos de 21
nodos_cheby_runge_11, ordenadas_cheby_runge_11 = F.nodos_ordenadas_cheby(F.runge_vec,
                                                       21,
                                                       [-1, 1])

#################
##    Gauss    ##
#################
# Para los nodos de 11
nodos_cheby_gauss_11, ordenadas_cheby_gauss_21 = F.nodos_ordenadas_cheby(F.exp_vec,
                                                       11,
                                                       [-1, 1])

# Para los nodos de 21
nodos_cheby_gauss_21, ordenadas_cheby_gauss_21 = F.nodos_ordenadas_cheby(F.exp_vec,
                                                       21,
                                                       [-1, 1])


