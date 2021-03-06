########################################################################
# Copyright 2019 Roku, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
########################################################################
import os

import requests
from robot.api.deco import keyword
from webDriver import WebDriver
from time import sleep
import time
from time import strftime
import subprocess
import json
from datetime import datetime, timedelta
from random import randint
import base64
from selenium import webdriver
from variables import ip_roku, endpoint_mfw, endpoint_cvr
from selenium.webdriver.common.keys import Keys


# import qa_functions

class RobotLibrary:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self, ip, timeout=0, pressDelay=0, path=""):
        self._process = None
        if len(path) > 0:
            self._process = subprocess.Popen(path)
        self.ROBOT_LIBRARY_LISTENER = self
        self.locatorHandlers = {
            "attr": self._checkAttribute,
            "tag": self._checkTag,
            "text": self._checkText
        }
        self._client = WebDriver(ip, timeout, pressDelay)
        self.markTimer()

    def close(self):
        self._client.quiet()
        if self._process != None:
            self._process.kill()

    @keyword("Mark timer")
    def markTimer(self):
        self._startTime = datetime.now()

    @keyword("Get timer")
    def getTimer(self):
        currentTime = datetime.now()
        delta = currentTime - self._startTime
        return int(delta / timedelta(milliseconds=1))

    @keyword("Side load")
    def sideLoad(self, path, user, password):
        multipart_form_data = {
            'channel': ('rokub0.zip', open(path, 'rb')),
            'username': (None, user),
            'password': (None, password)
        }
        response = self._client.side_load(multipart_form_data)
        self._checkResponse(response)

    @keyword("Launch the channel")
    def launchTheChannel(self, channel_code, contentId="", mediaType=""):
        launch_response = self._client.send_launch_channel(channel_code, contentId, mediaType)
        self._checkResponse(launch_response)

    @keyword("Get apps")
    def getApps(self):
        apps_response = self._client.get_apps()
        self._checkResponse(apps_response)
        res = json.loads(apps_response.text)
        return res['value']

    @keyword("Verify is channel exist")
    def verifyIsChannelExist(self, apps, id):
        for app in apps:
            if app['ID'] == id:
                return True
        raise Exception("Channel doesn't exist")

    @keyword("Verify is screen loaded")
    def verifyIsScreenLoaded(self, data: object, retries=10, delay=1):
        print(data)
        while retries > 0:
            ui_layout_response = self._client.get_ui_element(data)
            if ui_layout_response.status_code != 200:
                retries -= 1
                sleep(delay)
            else:
                return True
        raise Exception("Can't find element")

    @keyword("Send key")
    def pressBtn(self, key_press: str, delay=2):
        sleep(delay)
        key_press_response = self._client.send_keypress(key_press)
        self._checkResponse(key_press_response)

    @keyword("Send word")
    def sendWord(self, word: str, delay=2):
        sleep(delay)
        for c in word:
            sleep(0.5)
            key_press_response = self._client.send_keypress(f"LIT_{c}")
            self._checkResponse(key_press_response)

    @keyword("Send keys")
    def sendButtonSequence(self, sequence, delay=2):
        sleep(delay)
        key_press_response = self._client.send_sequence(sequence)
        self._checkResponse(key_press_response)

    @keyword("Get element")
    def getElement(self, data: object, delay=1):
        sleep(delay)
        ui_layout_response = self._client.get_ui_element(data)
        self._checkResponse(ui_layout_response)
        res = json.loads(ui_layout_response.text)
        return res['value']

    @keyword("Get elements")
    def getElements(self, data: object, delay=1):
        sleep(delay)
        ui_layout_response = self._client.get_ui_elements(data)
        self._checkResponse(ui_layout_response)
        res = json.loads(ui_layout_response.text)
        return res['value']

    @keyword("Get focused element")
    def getFocusedElement(self):
        ui_layout_response = self._client.get_active_element()
        self._checkResponse(ui_layout_response)
        res = json.loads(ui_layout_response.text)
        return res['value']

    @keyword("Verify is channel loaded")
    def verifyIsChannelLoaded(self, id, retries=10, delay=1):
        while retries > 0:
            app_response = self._client.get_current_app()
            self._checkResponse(app_response)
            res = json.loads(app_response.text)
            if res['value']['ID'] != id:
                retries -= 1
                sleep(delay)
            else:
                return True
        raise Exception("Channel isn't launched")

    @keyword("Get current channel info")
    def getCurrentChannelInfo(self):
        app_response = self._client.get_current_app()
        self._checkResponse(app_response)
        res = json.loads(app_response.text)
        return res['value']

    @keyword("Get device info")
    def getDeviceInfo(self):
        response = self._client.get_device_info()
        self._checkResponse(response)
        res = json.loads(response.text)
        return res['value']

    @keyword("Get player info")
    def getPlayerInfo(self):
        response = self._client.get_player_info()
        self._checkResponse(response)
        res = json.loads(response.text)
        value = res['value']
        value['Position'] = int(self._getMsFromString(value['Position']))
        value['Duration'] = int(self._getMsFromString(value['Duration']))
        return response

    @keyword("Verify is playback started")
    def verifyIsPlaybackStarted(self, retries=10, delay=1):
        while retries > 0:
            response = self._client.get_player_info()
            res = json.loads(response.text)
            if response.status_code != 200 or res['value']['State'] != 'play':
                retries -= 1
                sleep(delay)
            else:
                return True
        raise Exception("Invalid player state")

    @keyword("Set timeout")
    def setTimeout(self, timeout: int):
        response = self._client.set_timeouts("implicit", timeout)
        self._checkResponse(response)

    @keyword("Set press delay")
    def setDelay(self, delay: int):
        response = self._client.set_timeouts("pressDelay", delay)
        self._checkResponse(response)

    @keyword("Get attribute")
    def getAttribute(self, element, attr):
        for attrObj in element['Attrs']:
            if attrObj['Name']["Local"] == attr:
                return attrObj['Value']
        raise Exception("Can't find attribute")

    @keyword("Input deep linking data")
    def inputDeepLinkingData(self, channelId, contentId, mediaType):
        launch_response = self._client.send_input_data(channelId, contentId, mediaType)
        self._checkResponse(launch_response)

    @keyword("Get child nodes")
    def getChildNodes(self, parentNode, locators):
        childNodes = parentNode.Nodes
        result = []
        if childNodes == None:
            return result
        if locators == None:
            return result
        for node in childNodes:
            if self._isElementMatchLocators(node, locators) == True:
                result.append(node)
            result.extend(self.getChildNodes(node, locators))
        return result

    def _isElementMatchLocators(self, node, locators):
        for locator in locators:
            if hasattr(locator, 'using') == False:
                return False
            handler = self.locatorHandlers[locator.using]
            if handler == None:
                return False
            isMatch = handler(node, locator)
            if isMatch == False:
                return False
        return True

    def _checkAttribute(self, node, locator):
        if hasattr(node, 'Attrs') == False or hasattr(locator, 'value') == False or hasattr(locator,
                                                                                            'attribute') == False:
            return False
        for attr in node.Attrs:
            matchName = attr.Name.Local.lower() == locator.attribute.lower()
            matchValue = attr.Value.lower() == locator.value.lower()
            if matchName and matchValue:
                return True
        return False

    def _checkTag(self, node, locator):
        return node.XMLName.Local.lower() == locator.value.lower()

    def _checkText(self, node, locator):
        if hasattr(node, 'Attrs') == False or hasattr(locator, 'value') == False:
            return False
        for attr in node.Attrs:
            matchName = attr.Name.Local.lower() == "text"
            matchValue = attr.Value.lower() == locator.value.lower()
            if matchName and matchValue:
                return True
        return False

    def _checkResponse(self, response):
        if response.status_code == 400:
            raise Exception(response.text)
        elif response.status_code != 200:
            res = json.loads(response.text)
            raise Exception(res['value']['message'])

    def _getMsFromString(self, str):
        data = str.split(' ')
        return data[0]

    # Métodos y funciones QA

    @keyword("Convert mail")
    def convertMail(self, userMail):
        userMailArray = userMail.split("@")
        return userMailArray

    @keyword("Create mail")
    def crearMail(self):
        basemail = "mailRegistro"
        aleatorio = str(randint(0, 99999999))
        finmail = "@gmail.com"
        mailRegister = str(basemail + aleatorio + finmail)
        return mailRegister

    @keyword("Screenshot")
    def screenshot(self, path, name, roku_user, roku_pass):
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

    #Devuelve el tiempo de Duracion o de posicion del player dependiendo de la key seleccionada
    @keyword("Informacion player")
    def info_player(self, key):
        response = self.getPlayerInfo()
        res = json.loads(response.text)
        value = res['value']
        informacion = self._getMsFromString(value[key])
        return informacion

    #Compara la posicion del player al acceder a un contenido dos veces
    @keyword('Comparar tiempo de reproduccion')
    def equal_times(self, tiempo_viejo, tiempo_nuevo):
        tiempo_viejo = int(tiempo_viejo)
        tiempo_nuevo = int(tiempo_nuevo)
        if (tiempo_viejo >= tiempo_nuevo) and (tiempo_nuevo > (tiempo_viejo - 15000)):
            return True
        else:
            return False

    # Adelanta un contenido hasta el final
    @keyword("Adelantar")
    def adelantar(self, Duracion):
        Position = self.info_player('Position')
        while Position < Duracion - 2000:
            self.pressBtn('Fwd')
            self.pressBtn('Fwd')
            self.pressBtn('Fwd')
            time.sleep(6)
            self.pressBtn('Play')
            Position = self.info_player('Position')

    @keyword("Verificar inicio de contenido")
    def equal_times(self, Position):
        if Position <= 5000:
            return True
        else:
            return False

    def _get(self, request_url: str, params: object):
        params = str(params)
        params = params.replace('\'', '')
        params = params.replace(':', '=')
        params = params.replace(' ', '')
        params = params.replace(',', '&')
        params = params.replace('{', '')
        params = params.replace('}', '')
        request_url = request_url + params
        return requests.get(url=request_url)

    def params_standar_api_cv(self, version):
        parametros = {'api_version': version,
                      'authpn': 'roku',
                      'authpt': 'IdbIIWeFzYdy',
                      'device_category': 'stb',
                      'device_manufacturer': 'roku',
                      'device_model': 'generic',
                      'device_type': 'generic',
                      'format': 'json',
                      'HKS': 'web60467cec0114e'}
        return parametros

    @keyword("${file_name} Data ${node_and_key}")
    def get_data(self, file_name, node_and_key):
        directory = os.getcwd()
        directory_name = directory + file_name
        node_and_key = node_and_key.split(".")
        for a in range(0, len(node_and_key)):
            try:
                node_and_key[a] = int(node_and_key[a])
                print('int: ' + node_and_key[a])
            except:
                print('NotAnInteger: ' + node_and_key[a])
                bo = False
        if node_and_key[0] == 'response' or node_and_key[0] == 'errors':
            node_and_key.pop(0)
        if len(node_and_key) == 1:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]]
        elif len(node_and_key) == 2:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]]
        elif len(node_and_key) == 3:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]]
        elif len(node_and_key) == 4:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]][node_and_key[3]]
        elif len(node_and_key) == 5:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]][node_and_key[3]][node_and_key[4]]
        elif len(node_and_key) == 6:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]][node_and_key[3]][node_and_key[4]][
                node_and_key[5]]
        elif not len(node_and_key) == 7:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]][node_and_key[3]][node_and_key[4]][
                node_and_key[5]][node_and_key[6]]
        else:
            with open(directory_name, 'r') as fp:
                data_login = json.load(fp)
            return data_login[node_and_key[0]][node_and_key[1]][node_and_key[2]][node_and_key[3]][node_and_key[4]][
                node_and_key[5]][node_and_key[6]][node_and_key[7]]

    @keyword("Login by API")
    def login(self, user, password):
        endpoint = endpoint_mfw
        route = '/services/user/login?'
        url = endpoint + route
        params = self.params_standar_api_cv('v5.86')
        params.update({'includPaywayProfile': '1',
                       'password': password,
                       'username': user,
                       # Funciona igual sin los siguientes parametros
                       'appversion': '1.0.00001'})
        response = self._get(url, params)
        res = json.loads(response.text)
        if res['status'] == '0':
            value = res['response']
        else:
            value = res['errors']
        directory = os.getcwd()
        file_name = '\data\login_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)

    @keyword("Purchase by API")
    def purchase(self, region, user_id, group_id):
        endpoint = endpoint_mfw
        route = '/services/payway/purchasebuttoninfo?'
        url = endpoint + route
        params = self.params_standar_api_cv('v5.92')
        params.update({'region': region,
                       'user_id': user_id,
                       'group_id': group_id})
        response = self._get(url, params)
        res = json.loads(response.text)
        if res['status'] == '0':
            value = res['response']
        else:
            value = res['errors']
        directory = os.getcwd()
        file_name = '/data/purchase_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)

    @keyword("Getmedia by API")
    def getmedia(self, region, user_id, group_id, user_token, payway_token):
        endpoint = endpoint_mfw
        route = '/services/player/getmedia?'
        url = endpoint + route
        params = self.params_standar_api_cv('5.92')
        params.update({'region': region,
                       'user_id': user_id,
                       'group_id': group_id,
                       'user_token': user_token,
                       'payway_token': payway_token,
                       'device_id': 'f7785395-3dc0-5ca4-b2bd-b4e6346221e3',
                       'preview': 0,
                       'quality': 'HD',
                       'stream_type': 'smooth_streaming',
                       # Funciona igual sin los siguientes parametros
                       'appversion': '1.0.00001'})
        response = self._get(url, params)
        res = json.loads(response.text)
        try:
            value = res['response']
        except KeyError:
            value = res['errors']
        directory = os.getcwd()
        file_name = '/data/getmedia_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)

    @keyword("Register by API")
    def register(self, region, user, password, firstname="", lastname=""):
        endpoint = endpoint_mfw
        route = '/services/user/register?'
        url = endpoint + route
        params = self.params_standar_api_cv('v5.86')
        params.update({'region': region,
                       'includPaywayProfile': 'true',
                       'email': user,
                       'password': password,
                       'accepterms': 1,
                       # Funciona igual sin los siguientes parametros
                       'firstname': firstname,
                       'lastname': lastname})
        response = self._get(url, params)
        res = json.loads(response.text)
        if res['status'] == '0':
            value = res['response']
        else:
            value = res['errors']
        directory = os.getcwd()
        file_name = '/data/register_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)

    @keyword("level by API")
    def level(self, region, user_id):
        endpoint = endpoint_mfw
        route = '/services/cms/level?'
        url = endpoint + route
        params = {'api_version': 'v5.92',
                  'authpn': 'webclient',
                  'authpt': 'tfg1h3j4k6fd7',
                  'device_category': 'web',
                  'device_manufacturer': 'generic',
                  'device_model': 'web',
                  'device_type': 'web',
                  'format': 'json',
                  'HKS': 'web60520c18b8113',
                  'region': region,
                  'user_id': user_id,
                  'node': 'homeuser'}
        response = self._get(url, params)
        res = json.loads(response.text)
        if res['status'] == '0':
            value = res['response']
        else:
            value = res['errors']
        directory = os.getcwd()
        file_name = '/data/level_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)

    @keyword("level internal by API")
    def level_internal(self, region, user_hash):
        #Sin terminar. Error, respuesta viene completamente vacía.
        endpoint = endpoint_cvr
        route = '/level?'
        url = endpoint + route
        params = {'hks': 'web60467cec0114e',
                  'region': region,
                  'user_hash': user_hash}
        response = self._get(url, params)
        #res = json.loads(response.text)
        '''value = res['items']
        directory = os.getcwd()
        file_name = '/data/level_internal_data.json'
        directory_name = directory + file_name
        with open(directory_name, 'w') as fp:
            json.dump(value, fp)'''
        return response
