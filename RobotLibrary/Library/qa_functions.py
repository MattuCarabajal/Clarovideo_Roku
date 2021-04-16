from time import sleep
import base64
from selenium import webdriver
import time
from time import strftime
from variables import ip_roku
from random import randint
from selenium.webdriver.common.keys import Keys


def convertMail(userMail):
    userMailArray = userMail.split("@")
    return userMailArray


def crearMail():
    basemail = "mailRegistro"
    aleatorio = str(randint(0, 99999999))
    finmail = "@gmail.com"
    mailRegister = str(basemail + aleatorio + finmail)
    return mailRegister


def screenshot(path, name, roku_user, roku_pass):
    '''Parámetros
                    path: directorio desde donde se ejecuta el .robot
                    name: nombre del caso ejecutado
                    roku_user: usuario dev de roku
                    roku_pass: contraseña dev de roku
    '''

    # path es el directorio desde donde se ejecuta el .robot
    # path2 es la carpeta images adentro del directorio donde se ejecuta el .robot
    path2 = "/images/"
    # name es el nombre del caso ejecutado y la fecha
    name = strftime("%Y-%m-%d_%H-%M-%S") + '__' + name
    # end_path es el directorio completo incluyendo el nombre de la imagen que se va a guardar
    end_path = path + path2 + name + ".jpg"

    # Abrir el navegador y maximizarlo
    navigator = webdriver.Firefox()
    navigator.fullscreen_window()

    # Acceder al ip del roku incluyendo usuario y contraseña de desarrollador
    url = 'http://' + roku_user + ':' + roku_pass + '@' + ip_roku
    navigator.get(url)
    time.sleep(3)

    # Navegar a plugin_inspect donde se saca el screenshot
    navigator.get('http://' + ip_roku + '/plugin_inspect')
    time.sleep(3)

    # Buscar y clickear el boton de screenshot
    time.sleep(3)
    navigator.find_element_by_xpath("//button[text() = 'Screenshot']").click()
    time.sleep(3)

    # Seteo de zoom out para sacar el screenshot sin salir cortado
    navigator.set_context('chrome')
    page = navigator.find_element_by_tag_name('html')

    for i in range(1, 4):
        page.send_keys(Keys.CONTROL + '-')
        sleep(1)

    # Vuelta a la normalidad
    navigator.set_context('content')

    # Obtener el elemento de la imagen
    img = navigator.find_element_by_xpath('//div[@class="roku-page-content"]//img')
    # Sacar un screenshot de la imagen seleccionada en encondeo base64
    img = img.screenshot_as_base64
    # Traducir la imagen de encondeo base64 a utf-8
    base64_img_bytes = img.encode('utf-8')
    # Decodificar y guardar la imagen
    # Con parametro end_path (el directorio completo con el nombre del archivo y extensión. Se creo más arriba)
    with open(end_path, 'wb') as file_to_save:
        decoded_image_data = base64.decodebytes(base64_img_bytes)
        file_to_save.write(decoded_image_data)

    # Cerrar el navegador
    navigator.close()

def info_player(info, key):
    position = info.get(key)
    return position

def equal_times(tiempo_viejo, tiempo_nuevo):
    if tiempo_viejo >= tiempo_nuevo and (tiempo_nuevo > (tiempo_viejo - 15000)):
        return True
    else:
        return False
