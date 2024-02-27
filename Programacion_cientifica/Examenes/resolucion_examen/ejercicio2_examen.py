import string as str
dicesp_morse  = {   'A':'.-', 'B':'-...', 'C':'-.-.',
                    'D':'-..', 'E':'.','F':'..-.',
                    'G':'--.', 'H':'....', 'I':'..',
                    'J':'.---', 'K':'-.-', 'L':'.-..',
                    'M':'--', 'N':'-.', 'O':'---',
                    'P':'.--.', 'Q':'--.-','R':'.-.',
                    'S':'...','T':'-','U':'..-',
                    'V':'...-','W':'.--','X':'-..-',
                    'Y':'-.--','Z':'--..','1':'.----',
                    '2':'..---','3':'...--','4':'....-',
                    '5':'.....', '6':'-....', '7':'--...',
                    '8':'---..', '9':'----.','0':'-----',
                    '.':'.-.-.-', ',':'--..--', ':':'---...',
                    ';':'-.-.-.', '?':'..--..', '!':'-.-.--',
                    '"':'.-..-.', "'" :'.----.','+':'.-.-.',
                    '-':'-....-', '/':'-..-.','=':'-...-', 
                    '_':'..--.-', '$':'...-..-', '@':'.--.-.',
                    '&':'.-...', '(':'-.--.', ')':'-.--.-'}
# Tal y como se ha hecho el codigo necesitamos la palabra en mayuscula
def traducir_a_morse(palabra, diccionario_morse):
    # Se podria llevar la palabra a mayusculas, pero no recuerdo el comando. Recuerdo que era similar a toUpper (al menos en pyspark)
    # Recibe una palabra asi que la recorremos
    lista_letras = []
    lista_codigo = []
    for i in range(len(palabra)):
        lista_letras.append(palabra[i])

    for letra in lista_letras:
        lista_codigo.append(diccionario_morse[letra])

    palabra_morse = ''
    for letra in lista_codigo:
        palabra_morse+=letra
    return palabra_morse, lista_codigo
codigo, lista_codigo = traducir_a_morse('HOLA', dicesp_morse)
print(codigo)
print(lista_codigo)

