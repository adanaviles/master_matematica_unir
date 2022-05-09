# Podemos usar string y ascii_lowercase. Tambien lo haremos con
# a)
import string 
abecedario_ascii = list(string.ascii_lowercase)
abecedario = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
            'l', 'm', 'n', 'o', 'p' , 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

# b)
###
# c)
consonantes = [ 'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k',
            'l', 'm', 'n', 'p' , 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
vocales = list(filter(lambda x: x not in consonantes, abecedario))
vocales = list(filter(lambda x: x =='a' or x=='e' or x=='i' or x=='o' or x=='u', abecedario))
print(vocales)
