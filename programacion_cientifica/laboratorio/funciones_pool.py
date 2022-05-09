import pandas as pd
import multiprocessing as mp
import numpy as np
import time
import datetime as DT
#modulo para usar expresiones regulares
import re
from multiprocessing import Pool
#importación del corpus brown
from nltk.corpus import brown


def construye_textos():
    """ 
        Funcion que construye el DataFrame para su procesamiento, on una frase por fila
    Returns:
        Lista de con textos de corpus brown
    """
    return [" ".join(np.random.permutation(sents)) for sents in brown.sents()]

def construye_datafame_texto(nombre_columna="text"):
    """ 
        Funcion que crea un dataframe a partir de una lista de textos y 
        pone como nombre de la columna el pasado por argumentos. En caso de no pasar ninguna
        por default es 'text'.
    """
    lista = construye_textos()
    df = pd.DataFrame(lista, columns= [nombre_columna] )
    return df


def reemplazar_comillas(df, nombre_columna='text'):
    """ Funcion que reemplaza comillas dobles en un dataframe. Pasamos el nombre de la columna
        como parámetro.  En caso de no pasar ninguna por default es 'text'.
    """
    df[nombre_columna] = df[nombre_columna].apply(lambda text: text.replace("``",'"'))
    return df

def a_minusculas(df, nombre_columna = "text"):
    """ Funcion que convierte todas las palabras a minúsculas en un dataframe.
        Pasamos el nombre de la columna como parámetro,  En caso de no pasar ninguna
        por default es 'text'.
    """
    df[nombre_columna] = df[nombre_columna].apply(lambda text: text.lower())
    return df

def contar_palabras(df, nombre_columna='text'):
    """ funcion que cuenta palabras de cada fila del dataframae y añade una columna con el resultado
    Args:
        df: Dataframe
        nombre_columna: Nombre de la columna de la que queremos contar palabras.  En caso de no pasar ninguna
        por default es 'text'.

    Returns:
        dataframe con una columna 'num_palabras' y el numero de palabras
    """
    df['num_palabras'] = df[nombre_columna].apply(lambda text: len(re.split(r"(?:\s+)|(?:,)|(?:\-)",text)))
    return df
    


def procesar_df(df):
  """ Función que se aplicará al df para procesarlo

  Args:
      df (_type_): Dataframe original
      nombre_columna (_type_): Nombre de la columna de texto. En caso de no pasar ninguna
        por default es 'text'.

  Returns:
     salida_df : 
  """
  # Se hace copia del dataframe para no modificarlo
  salida_df = df.copy()

  # Reemplaza las comillas
  salida_df['text'] = reemplazar_comillas(salida_df, 'text')

  # Pasa el texto a minusculas
  salida_df['text']  = a_minusculas(salida_df, 'text')

  # cuenta el número de palabras y construye columna nueva con nombre num_palabras
  salida_df = contar_palabras(salida_df, 'text')
     

  # Elimina los textos demasiado largos
  texto_largo_para_eliminar = salida_df[salida_df['num_palabras'] > 50]
  salida_df.drop(texto_largo_para_eliminar.index, inplace=True)

  # Elimina los textos demasiado cortos
  texto_corto_para_eliminar = salida_df[salida_df['num_palabras'] < 10]
  salida_df.drop(texto_corto_para_eliminar.index, inplace=True)    

  # Reinicializa los indices
  salida_df.reset_index(drop=True, inplace=True)

  return salida_df

