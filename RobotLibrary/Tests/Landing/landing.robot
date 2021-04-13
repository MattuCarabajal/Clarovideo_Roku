*** Settings ***
Documentation   Suite Landing
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py     ${ip_address}   ${timeout}  ${pressDelay}   ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel

Test Setup      Launch the channel  ${channel_code}
Test Teardown   Run if fails

*** Test Cases ***
01_0002_LANDING_Verificar_poster_fondo_de_pantalla
    #Verificar que se cargó la pantalla Landing
    ${element}=     Element identifier    attr    name    fondo
    Verify is screen loaded     ${element}

01_0003_LANDING_Visualizar_objeto_inicia_de_sesión
    [Tags]
    #Localiza el elemento btnlogin en la pantalla
    ${element}=     Element identifier    attr    name    btnlogin
    #Verifica que el elemento haya cargado
    Verify is screen loaded     ${element}

01_0005_LANDING_Verificar_texto_botón_inicia_sesion
    [Tags]
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Localiza un nodo especifico del elemento
    ${Node}         Get element by parentData    attr    bounds    {8, 8, 328, 32}     attr     name     btnlogin
    #Guarda el atributo texto del elemento que encontro
    ${Value}        Get attr by ParentData     ${Node}      text
    #Compara el valor del atributo del elemento con el valor que deberia tener
    Assert Equal    ${Value}     INICIA SESIÓN

01_0006_LANDING_Verificar_color_texto_boton _inicia_sesion
    [Tags]
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Localiza un nodo especifico del elemento
    ${Node}         Get element by parentData   attr    bounds    {8, 8, 328, 32}   attr    name    btnlogin
    #Guarda el atributo color del elemento que encontro
    ${Value}        Get attr by ParentData     ${Node}      color
    #Compara el valor del atributo del elemento con el valor que deberia tener
    Assert Equal    ${Value}     \#ffffffff


01_0007_LANDING_Verificar_funcionalidad_botón_inicio_sesión
    [Tags]   Critical
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Desplazamiento para seleccionar el boton de inicio de sesión
    Send key        Down
    Send key        Select
    #Localiza el elemento title
    ${element}=     Element identifier      attr    name    title
    #Verifica que la pantalla de inicio de sesión haya cargado localizando el elemento title que se ubica en dicha pantalla
    Verify is screen loaded     ${element}

01_0008_LANDING_Visualizar_objeto_botón_registrate
    [Tags]
    #Localiza el elemento btnRegister en la pantalla
    ${element}=     Element identifier    attr    name    btnRegister
    #Verifica que el elemento haya cargado
    Verify is screen loaded     ${element}

01_0010_LANDING_Verificar_texto_botón_registrate
    [Tags]
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Localiza un nodo especifico del elemento
    ${Node}         Get element by parentData    attr    bounds    {8, 8, 328, 32}     attr     name     btnRegister
    #Guarda el atributo texto del elemento que encontro
    ${Value}        Get attr by ParentData     ${Node}      text
    #Compara el valor del atributo del elemento con el valor que deberia tener
    Assert Equal    ${Value}     REGÍSTRATE

01_0011_LANDING_Verificar_color_texto_botón_registrate
    [Tags]
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Localiza un nodo especifico del elemento
    ${Node}         Get element by parentData    attr    bounds    {8, 8, 328, 32}     attr     name     btnRegister
    #Guarda el atributo color del elemento que encontro
    ${Value}        Get attr by ParentData     ${Node}      color
    #Compara el valor del atributo del elemento con el valor que deberia tener
    Assert Equal   ${Value}      \#ffffffff

01_0012_LANDING_Verificar_funcionalidad_botón_registrate
    [Tags]   Critical
    #Verifica que la pantalla haya cargado localizando el elemento fondo
    Wait until      attr    name    fondo
    #Seleccionar el boton REGISTRASE
    Send key        Select
    #Localizar el elemento title en la pantalla de Registro
    ${element}=     Element identifier      attr    name    title
    #Verficar que la pantalla Registro haya cargado visualizando el elemento title
    Verify is screen loaded     ${element}

01_0013_LANDING_Visualizar_objeto_todo_lo_que_te_gusta_en_un_solo_lugar
    [Tags]
    #Localiza el elemento title
    ${element}=     Element identifier      attr    name    title
    #Verifica que la pantalla haya cargado localizando el elemento title
    Verify is screen loaded     ${element}

01_0014_LANDING_Visualizar_texto_todo_lo_que_te_gusta_en_un_solo_lugar
    [Tags]
    #Espera hasta que el elemento fondo aparezca
    Wait until      attr    name    fondo
    #Localiza el elemento title y guarda el value del atributo text
    ${text}=        Get attr    attr    name    title   text
    #Verifica que el value del atributo text sea el mismo que el que se solicita segun requerimiento
    Assert Equal    ${text}     ¡Todo lo que te gusta en un sólo lugar!

01_0016_LANDING_Visualizar_objeto_el_mejor_contenido_canales_de_tv_peliculas_series
    [Tags]
    #Se localiza el elemento descrip
    ${element}=     Element identifier      attr    name    descrip
    #Se Verifica que la pantalla haya cargado localizando el elemento descrip
    Verify is screen loaded     ${element}

01_0017_LANDING_Visualizar_texto_el_mejor_contenido_canales_de_tv_peliculas_series
    [Tags]
    #Espera hasta que el elemento fondo aparezca
    Wait until      attr    name    fondo
    #Localiza el elemento descrip y guarda el value del atributo text
    ${text}=        Get attr    attr    name    descrip   text
    #Verifica que el value del atributo text sea el mismo que el que se solicita segun requerimiento
    Assert Equal    ${text}     El mejor contenido, canales de TV, películas y series.
