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
from numpy.polynomial import chebyshev
import time
from scipy.interpolate import barycentric_interpolate 
from scipy.linalg import norm
from scipy.interpolate import lagrange
from scipy.interpolate import InterpolatedUnivariateSpline 

###############################################################################
##                   Definicion de funciones  para ejercicios                ##
###############################################################################

# Seno
sin_vec  = np.vectorize(math.sin)

#Funcion de runge, no es necesario vectorizarla.
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

############################
# Funcion que devuelve los nodos y ordenadas de Chebyshev para una función
# e intervalo dados
############################
def nodos_ordenadas(funcion, nodos, intervalo):
    """ Funcion que devuelve los nodos y ordenadas para una función
        e intervalo dados.

    Args:
        funcion: Funcion que se aplica para encontrar las ordenadas
        puntos: Numero de nodos que queremos
        intervalo: Intervalo en el que estudiaremos en formato array [a,b]

    Returns:
        nodos: Nodos
        ordenadas: Ordenadas funcion(nodos)

    """
    coefs_Cheby = [0]*nodos+[1]
    Tpuntos = chebyshev.Chebyshev(coefs_Cheby, intervalo)
    nodos_cheby = Tpuntos.roots()
    ordenadas_cheby = funcion(nodos_cheby)
    return nodos, ordenadas


############################
# Funcion que devuelve los nodos y ordenadas de Chebyshev para una función
# e intervalo dados
############################
def nodos_ordenadas_cheby(funcion, nodos, intervalo):
    """ Funcion que devuelve los nodos y ordenadas de Chebyshev para una función
        e intervalo dados.

    Args:
        funcion: Funcion que se aplica para encontrar las ordenadas
        puntos: Numero de nodos que queremos
        intervalo: Intervalo en el que estudiaremos en formato array [a,b]

    Returns:
        nodos_cheby: Nodos de Chebyshev
        ordenadas_cheby: Ordenadas de Chebyshev; funcion(nodos)

    """
    coefs_Cheby = [0]*nodos+[1]
    Tpuntos = chebyshev.Chebyshev(coefs_Cheby, intervalo)
    nodos_cheby = Tpuntos.roots()
    ordenadas_cheby = funcion(nodos_cheby)
    return nodos_cheby, ordenadas_cheby

############################
# Función que calcula la interpolacion baricentrica y devuelve error, tiempo y plot.
############################
def inter_bar(nodos,funcion,intervalo):
    """ Esta función hace la interpolación baricéntrica, crea su plot y calcula el error y tiempo
    que se tarda en hacer la interpolación. 
    
    Args:
        nodos : Lista de nodos para interpolar 
        funcion :  Funcion que se quiere interpolar.
        intervalo : Lista de puntos donde se evaluará el polinomio baricentrico tras ser calculado
        
    Returns:
        pol: Devuelve el valor de los puntos del intervalo evaluados con el polinomio interpolador.
             Recordemos que barycentric_interpolate no nos devuelve los coeficientes del polinomio, 
             sino que evalua el polinomio en el intervalo que le damos.
        fig: Devuelve el plot.
        tiempo_ejecucion: Tiempo que tarda en ejecutarse la interpolacion
        error: Error de la interpolacion respecto al intervalo original.
        
        
    """
    # Recordemos que barycentric_interpolate no nos devuelve los coeficientes del polinomio, 
    # sino que evalua el polinomio en el intervalo que le damos.
    abscisas_nodo = funcion(nodos)
    inicio = time.perf_counter()
    pol = barycentric_interpolate(nodos, abscisas_nodo, intervalo)
    fin = time.perf_counter()
    # Tiempo total
    tiempo_ejecucion = str(fin-inicio) + ' segundos'
    
    # Error total
    error = norm(pol-funcion(intervalo))
    
    # Creacion del plot
    fig = plt.figure()
    plt.plot(nodos, abscisas_nodo, "ko", figure = fig)
    plt.xlabel('x', figure=fig)
    plt.plot(intervalo, pol, 'c', label = 'polinomio interpolador', figure = fig)
    plt.plot(intervalo, funcion(intervalo), 'g:',label='función', figure = fig)
    plt.title("Interpolación baricéntrica", figure = fig)
    plt.legend()
    plt.close(fig) #Usado para no mostrar la figura por pantalla al ejecutar la funcion
    
    return pol, fig, tiempo_ejecucion, error

########################################################################################################################################

##################################
# Función que calcula la interpolacion baricentrica y devuelve error, tiempo y plot.
############################
def inter_lagrange(nodos,funcion,intervalo):
    """ Esta función hace la interpolación baricéntrica, crea su plot y calcula el error y tiempo
    que se tarda en hacer la interpolación. 
    
    Args:
        nodos : Lista de nodos para interpolar 
        funcion :  Funcion que se quiere interpolar.
        intervalo : Lista de puntos donde se evaluará el polinomio para calcular el error
        
    Returns:
        pol: Devuelve el polinomio
        fig: Devuelve el plot.
        tiempo_ejecucion: Tiempo que tarda en ejecutarse la interpolacion
        error: Error de la interpolacion respecto al intervalo original.
        
        
    """
    # Pol es un poliunomio evaluable
    ordenadas = funcion(nodos)
    inicio = time.perf_counter()
    pol = lagrange(nodos, ordenadas)
    fin = time.perf_counter()
    # Tiempo total
    tiempo_ejecucion = str(fin-inicio) + ' segundos'
    
    # Error total
    
    error = norm(pol(intervalo)-funcion(intervalo))
    
    # Creacion del plot
    fig = plt.figure()
    plt.plot(nodos, ordenadas, "ko", figure=fig)
    plt.xlabel('x', figure = fig)
    plt.plot(intervalo, pol(intervalo),'c', label = 'polinomio interpolador de Lagrange', figure = fig)
    plt.plot(intervalo, funcion(intervalo), 'g:', label = 'función', figure=fig)
    plt.title("Interpolación de Lagrange", figure = fig)
    plt.legend()
    plt.close(fig) #Usado para no mostrar la figura por pantalla al ejecutar la funcion
    
    return pol, fig, tiempo_ejecucion, error

########################################################################################################################################

############################
# Funcion para el método de las diferencias divididas.
############################
def diferencias_divididas(xi, yi):
    """ Funcion que crea las diferencias divididas y devuelve el polinomio de Newton, junto a una funcion ejecutable.

    Args:
        xi: Array de las equis
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

############################
# Función que calcula la interpolacion baricentrica y devuelve error, tiempo y plot.
############################
def inter_dd(nodos,funcion,intervalo):
    """ Esta función hace la interpolación mediante diferencias divididas, crea su plot y calcula el error y tiempo
    que se tarda en hacer la interpolación. Esta funcion se utiliza pues sigue el esquema de las anteriores, pero el codigo
    importante es el de diferencias_divididas(xi,yi)
    
    Args:
        nodos : Lista de nodos para interpolar 
        funcion :  Funcion que se quiere interpolar.
        intervalo : Lista de puntos donde se evaluará el polinomio baricentrico tras ser calculado
        
    Returns:
        pol: Devuelve el polinomio de Newton simbolico. Para verlo, se ha de usar pprint.
        pol_numpy: Funcion llamable y ejecutable para obtener valores.
        matriz: Devuelve una matriz con las diferencias divididas.
        fig: Devuelve el plot.
        tiempo_ejecucion: Tiempo que tarda en ejecutarse la interpolacion
        error: Error de la interpolacion respecto al intervalo original.
        
        
    """
    
    ordenadas = funcion(nodos)
    inicio = time.perf_counter()
    matriz, pol, pol_numpy = diferencias_divididas(nodos, ordenadas)
    fin = time.perf_counter()
    # Tiempo total
    tiempo_ejecucion = str(fin-inicio) + ' segundos'
    
    # Error total
    error = norm(pol_numpy(intervalo)-funcion(intervalo))

    # Creacion del plot
    fig = plt.figure()
    plt.plot(nodos, ordenadas, "ko", figure=fig)
    plt.xlabel('x', figure = fig)
    plt.plot(intervalo, pol_numpy(intervalo),'c', label = 'polinomio interpolador de Newton', figure = fig)
    plt.plot(intervalo, funcion(intervalo), 'g:', label = 'función', figure=fig)
    plt.title("Interpolación de Newton", figure = fig)
    plt.legend()
    plt.close(fig) #Usado para no mostrar la figura por pantalla al ejecutar la funcion
    
    return pol, pol_numpy, matriz, fig, tiempo_ejecucion, error

########################################################################################################################################
############################
# Función que calcula la interpolacion  por splines cubicos
############################
def inter_splines(nodos,funcion,intervalo, titulo):
    '''
    Función que calcula la interpolación por splines cúbicos, dados los nodos, una función, 
    y un vector de abscisas que será usado para representar la función y evaluar el error.
    Se le pasa un título descriptivo  para mostrar en el gráfico y en la salida estándar.
    Args:
        -nodos: vector de nodos usados para calcular los polinomios interpoladores por splines cúbicos
        -función: función que hay que interpolar
        -intervalo: vector de abscisas usadas para mostrar la función en un gráfico
        -titulo: descripción de la función y nodos utilizados para mostrar en las gráficas
    Returns:
        pol: Devuelve el polinomio de calculado por splines cubicos simbolico.
        fig: Devuelve el plot.
        tiempo_ejecucion: Tiempo que tarda en ejecutarse la interpolacion
        error: Error de la interpolacion respecto al intervalo original.
    '''
    ordenadas = funcion(nodos)
    inicio =time.perf_counter()
    pol = InterpolatedUnivariateSpline(nodos, ordenadas)
    fin = time.perf_counter()

    # Tiempo total
    tiempo_ejecucion = str(fin-inicio) + ' segundos'

    # Error total
    error = norm(pol(intervalo)-funcion(intervalo))

    # Creacion del plot
    fig = plt.figure()

    plt.plot(nodos, funcion(nodos), "ko", label="Función en Nodos", figure = fig)
    plt.xlabel('x',  figure = fig)
    plt.ylabel('y',  figure = fig)
    plt.plot(intervalo, pol(intervalo),'c',label='Splines Cúbicos',  figure = fig)
    plt.plot(intervalo,funcion(intervalo),'g:',label='función',  figure = fig)
    plt.title("Interpol. por Splines Cúbicos: " + titulo,  figure = fig)
    plt.legend()
    plt.close(fig) #Usado para no mostrar la figura por pantalla al ejecutar la funcion
    
    return pol, fig, tiempo_ejecucion, error