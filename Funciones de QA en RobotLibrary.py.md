# Funciones de QA en RobotLibrary.py

En este documento encontrarás una descripción de las funciones y métodos de QA que se encuentran en RobotLibrary.py  y como utilizar cada una de ellas.

### 1- Convert mail

Esta funcionalidad fue creada porque tenemos problemas con los @, ya que le dispositivo ROKU no reconoce correctamente ese caracter especial. 

Esta función toma la variable del mail completo y retorna una lista de dos componentes (los caracteres introducidos antes y luego del arroba). Ejemplo [amco@gmail.com](mailto:amco@gmail.com) retorna:

[“amco”, “gmail.com”]

**Parámetros requeridos:** mail

### 2- Create mail

Esta función no requiere ningún parámetro y devuelve un mail nuevo para poder crear una nueva cuenta. 

**Parámetros requeridos**: ninguno

### 3- Screenshot

Esta función se ejecuta en el Test Teardown de la ejecución de Robot. Se ejecuta solo si falla el test case y saca un screenshot del estado en el que quedó.  La imagen correspondiente queda alojada en la carpeta **images** dentro de la carpeta de la sección que se está ejecutando (login, landing, etc).

El nombre se compone por la fecha, horas, minutos y segundos actual y el nombre del test case. Ejemplo:

2021-02-25_14-28-45__Login with an invalid user and password.jpg

**Parámetros requeridos**: 

*path:* directorio desde donde se ejecuta el .robot

*name*: nombre del caso ejecutado

*roku_user*: usuario dev de roku

*roku_pass*: contraseña dev de roku

### 4- Informacion player

Se utiliza para tomar información del player cuando se está reproduciendo un contenido. 

La info que retorna es sobre el contenido reproducido

**Parámetros requeridos**: 

*key*: se coloca el nombre del campo que se quiere obtener. Por ejemplo: title, duration, description, etc. 

### 5- Comparar tiempo de reproducción

Esta función verifica la correcta implementación de las **seenlast**. Verifica que cuando salís de la reproducción de un contenido que no terminaste de ver y volvés a ingresar, el player esté el mismo bloque de 15 seg de reproducción que habías quedado. 

**Parámetros requeridos**: 

*tiempo_viejo:* el tiempo en que quedó el contenido al salir de reproductor

*tiempo_nuevo*: el tiempo en que comienza el contenido al volver a acceder.

### 6- Adelantar

Esta función adelanta el contenido hasta que termine. 

**Parámetros requeridos**: 

*Duración*

### 7- Verificar inicio de contenido

Esta función verifica que la reproducción comienza desde cero. 

**Parámetros requeridos:** 

*Position*

### 8- ${file_name} Data ${node_and_key}

Luego de llamar un API, con esta función se obtiene un parámetro de la respuesta de la misma. 

**Parámetros requeridos**: 

*${file_name}* : es el nombre del archivo donde se guardo la respuesta de la API correspondiente. Los mismo están guardados en \RobotLibrary\Library\variables.robot en la sección getData 

*${node_and_key}* : es el parámetro que se quiere obtener de la respuesta. Ejemplo: 

response.group.common.title

Para obtenerlo, en la pestaña preview de la llamada de la API correspondiente en Chrome, ubica el mouse sobre el parámetro requerido y en el menú contextual seleccionar  copy property path.

### 9- Login by API

Esta función llama a la API Login y guarda la respuesta en el archivo login_data.json

**Parámetros requeridos**: 

*user*

*password*

### 10- Purchase by API

Esta función llama a la API Purchase y guarda la respuesta en el archivo purchase_data.json

**Parámetros requeridos**: 

*region :* utilizar siempre esta variable ${region}

*user_id :* se toma de la respuesta Login by API

*Group_id:* el contenido que se quiere testear

### 11- Getmedia by API

Esta función llama a la API Getmedia y guarda la respuesta en el archivo Getmedia_data.json

**Parámetros requeridos**: 

*region :* utilizar siempre esta variable ${region}

*user_id :* se toma de la respuesta Login by API

*Group_id:* el contenido que se quiere testear

*user_token*: se toma de la respuesta Login by API

*paywaytoken*: se toma de la respuesta Purchase by API

### 12- Register by API

Esta función llama a la API Register y guarda la respuesta en el archivo register_data.json

**Parámetros requeridos**: 

*region :* utilizar siempre esta variable ${region}

user

password

firstname (opcional)

lastname (opcional)

### 13- Level by API

Esta función llama a la API Level y guarda la respuesta en el archivo level_data.json

**Parámetros requeridos**: 

*region :* utilizar siempre esta variable ${region}

*user_id :* se toma de la respuesta Login by API

### 14- Level internal by API

Esta función llama a la API Level dentro del middleware.  Esta API contiene la info de las llamadas cms/level y cms/leveluser en una sola.  

**Parámetros requeridos**: 

*region :* utilizar siempre esta variable ${region}

*user_hash:*  usar el parámetro session_userhash