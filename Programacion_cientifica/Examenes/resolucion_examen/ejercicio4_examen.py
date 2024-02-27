import pandas as pd
class TemperaturaEdificio:
    def __init__(self,nombre,localizacion,lista_estaciones,lista_temperaturas):
        self.nombre = nombre
        self.localizacion = localizacion
        self.dataframe = self.construirDataframe(lista_estaciones,lista_temperaturas)
        
    def construirDataframe(self, lista_estaciones,lista_temperaturas):
        # lista_temperaturas ha de ser una lista de listas
        df=pd.DataFrame(index=["P1","P2", "P3"])
        for i in range(0,len(lista_estaciones)):
            df[lista_estaciones[i]] = lista_temperaturas[i]       
        return df
    
    def obtener_temperatur_estacion(self,estacion):
        return self.dataframe[estacion]
    
    def obtener_temperatur_planta(self,planta):
        return self.dataframe.loc[planta]
    
    def maximo_y_minimo_estaciones(self):
            lista_maximos = []
            lista_minimos = []
            for col in self.dataframe.columns:
                lista_maximos.append(self.dataframe[col].max())
                lista_minimos.append(self.dataframe[col].min())
            self.dataframe.loc['maximo_en_la_estacion'] = lista_maximos
            self.dataframe.loc['minimo_en_la_estacion'] = lista_minimos
            return self.dataframe

    def maximo_y_minimo_planta(self):
        self.dataframe['maximo_en_planta'] = self.dataframe.max(axis=1)
        self.dataframe['minim_en_planta'] = self.dataframe.max(axis=1)
        return self.dataframe

    def __str__(self):
        # Primero hago que el dataframe tenga los maximos y los minimos asi que los ejecuto de esta forma para que el dataframe se soberescriba
        # Podriamos hacerlo con copias para no perder el original, pero tampoco se nos pide en un principio.
        self.dataframe['maximo_en_planta'] = self.dataframe.max(axis=1)
        self.dataframe['minim_en_planta'] = self.dataframe.max(axis=1)
        return "El edificio es :"+self.nombre+"\n Y esta localizado en "+ self.localizacion +" \nSus temperaturas por estacion son \n"+str(self.dataframe)

estaciones = ['Invierno', 'Verano', 'Primavera', 'Oton']
lista_temperaturas = [
                        [2.0, 7.5, 0.3], #temp invierno
                        [30, 31, 32.5], # temp verano
                        [15, 16, 17], # temp primavera
                        [8, 6.5, 12 ] # temp otn
                    ]
temp_edificio=TemperaturaEdificio("FranciscoRicci",'Madrid', estaciones, lista_temperaturas)
print(temp_edificio)
