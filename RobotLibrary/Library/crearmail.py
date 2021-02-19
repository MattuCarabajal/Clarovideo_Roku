import openpyxl


def cerosAntesDeUnTexto(texto, cantidad_final):
    while len(texto) < cantidad_final:
        texto = "0" + texto
    return texto

abrir_test= openpyxl.load_workbook('C:/Users/rjrodriguez/Documents/Test/tests_cases.xlsx')
Hoja= abrir_test['Registro'] #Aqui va el nombre de la hoja
A= Hoja['A']
#print(A) #Imprimo el numero de celdas que contienen datos

seccion = input("Que sección es esta?: ").upper() #investigar para que seccion sea igual a la hoja que estoy abriendo
numero_seccion = cerosAntesDeUnTexto(input("numero de seccion?: "),2)


rango = range(1,41)  #Si hay 10 casos el rango llega hasta 11
iterable_rango = iter(rango)

for celda in Hoja['A2':'A40']: #A1 es el titulo de la columna y A10 el ultimo caso que se mostro en el print de la linea 6
    valores= str(celda[0].value).split()
    casos_unidos= "_".join(valores)
    casos_listos= str(numero_seccion + "_" + cerosAntesDeUnTexto(str(next(iterable_rango)),4) + "_" + seccion + "_" + casos_unidos)
    print(casos_listos)

#investigar metodo append y los demas tambien para guardar en una hoja nueva
