import pandas as pd
datos = {'Invierno':[2.0, 7.5, 0.3],
        'Verano':[30, 31, 32.5], 
        'Primavera':[15, 16, 17],
        'Oton':[8, 6.5, 12 ]}

df_estaciones = pd.DataFrame(datos,index=["P1","P2", "P3"])
def maximo_y_minimo(df):
    lista_maximos = []
    lista_minimos = []
    for col in df.columns:
        lista_maximos.append(df[col].max())
        lista_minimos.append(df[col].min())
    df.loc['maximo_en_la_estacion'] = lista_maximos
    df.loc['minimo_en_la_estacion'] = lista_minimos
    return df

def maximo_y_minimo_planta(df):
    df['maximo_en_planta'] = df.max(axis=1)
    df['minim_en_planta'] = df.max(axis=1)
    return df 
    
df_nuevo =  maximo_y_minimo_planta(maximo_y_minimo(df_estaciones))
print(df_nuevo)
