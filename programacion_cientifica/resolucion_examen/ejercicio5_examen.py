import threading
class tablon_escritura:
    def __init__(self):

        # Ponemos otro semaforo para que solo una persona pueda escribir. O el jefe de fabrica o el de operaciones
        self.semaforo_escritor=threading.Semaphore(1)
        # Podemos crear un contador para saber cuandos opearrios estan leyendo, tambien lo podemos hacer con un semaforo
        self.semaforo_operario = threading.Semaphore(3)
        self.operarios=0
        # Creamos un true o false para saber si se esta escribiendo y lo iniciamos a false
        self.escribiendo = False
        # Pondremos tambien condicion para que si algun operario esta leyendo, los escritores esperen.
        self.leyendo_en_tablon=threading.Condition()
        # Necesitamos una exclusion mutua para evitar que si algun operario esta leyendo, no se escriban datos o para acceder al tablon y saber el numero de lectores
        self.exmutua=threading.Lock()
         # Pondremos tambien condicion para que si algun operario esta escribiendo, los lectores esperen.
        self.escribiendo_en_tablon=threading.Condition()

   
        
    def operario(self, name):
       # En primer lugar nos aseguramos de que no haya nadie escribiendo 
       # Si hay alguien escribiendo, espero
        with self.escribiendo_en_tablon:
            if self.escribiendo:
                self.escribiendo_en_tablon.wait()

        # comprueba que puede leer
        self.semaforo_operario.acquire() # estas comprobaciones habria que hacerlas en exclusion mutua para que varios operarios no lo hagan  a la vez
        # Simulo el tiempo de lectura con un timesleep, habria que poner un if para que en caso de no poder leer se marche
        self.semaforo_operario.release()
        with self.leyendo_en_tablon:
            self.leyendo_en_tablon.notifyAll()
        
    def jefe(self, name):
        #si hay gente leuendo en el tablon me espero
        with self.leyendo_en_tablon:
                self.leyendo_en_tablon.wait()
        # Compruebo que pueda acceder a escribir por si hay otro jefe
        self.semaforo_escritor.acquire()
        # habria que ir cambiando la escritura entre true y false
        self.escribiendo = True
        # Simulo el tiempo de escritura con un timesleep, habria que poner un if para que en caso de no poder escribir se marche
        
        with self.escribiendo_en_tablon:
            self.escribiendo = False
            self.escribiendo_en_tablon.notifyAll()
        self.semaforo_escritor.release()
        
if __name__=="__main__":
    # Dentro del main, llamamos a la clase y hacemos hilos. Varios para escritores y varios para jefes, diferenciando entre jefes de fabrica y operaciones

        tablon=tablon_escritura()
        t1 = threading.Thread(target = tablon.operario, name="Lector 1") 
        t1.join()
        t2 = threading.Thread(target = tablon.jefe, name="jefe fagibrca") 
        t2 = threading.Thread(target = tablon.jefe, name="jefe operacion") 
        # habria que hacer los join y start
    
        
        