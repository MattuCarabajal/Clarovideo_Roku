*** Settings ***
Documentation   Suite Login
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel
Test Setup      Access login
Test Teardown   Run if fails

*** Test Cases ***
03_0001_LOGIN-Visualizar_objeto_titulo_Inicia_sesion
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=     Element identifier      attr    name    title
    Verify is screen loaded     ${element}

03_0002_LOGIN_Verificar_texto_Inicia_sesion
    Wait until      attr    name    title
    ${text}=        Get attr    attr    name    title    text
    Assert Equal    ${text}     Inicia sesión

03_0004_LOGIN_Visualizar_objeto_descripcion_Cual_es_tu_correo_electronico
    #Verificar si el elemento descripción se visualiza en pantalla
    ${element}=     Element identifier      attr    name    descrip
    Verify is screen loaded     ${element}

03_0005_LOGIN_Verificar_objeto_descripción_contiene_texto_Cual_es_tu_correo_electronico
    Wait until      attr    name    descrip
    ${text}=        Get attr    attr    name    descrip    text
    Assert Equal    ${text}     ¿Cuál es tu correo electrónico?

03_0007_LOGIN_Verificar_placeholder_de_correo_electronico
    [Tags]
    Wait until      attr    name    user
    ${Node}         Get element by parentData   attr    bounds    {24, 11, 432, 26}   attr    name    user
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     Correo electrónico

03_0008_LOGIN_Verificar_placeholder_de_contrasenia
    [Tags]
    Wait until      attr    name    pass
    ${Node}         Get element by parentData   attr    bounds    {24, 11, 432, 26}   attr    name    pass
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     Contraseña

03_0009_LOGIN_Visualizar_objeto_boton_Siguiente
    [Tags]
    #Verificar si el objeto login se muestra en la pantalla
    ${element}=     Element identifier      attr    name    login
    Verify is screen loaded     ${element}

03_0010_LOGIN_Verificar_texto_botón_siguiente_contiene_el_texto_Siguiente
    [Tags]
    Wait until      attr    name    login
    ${Node}         Get element by parentData   attr    bounds    {8, 8, 464, 32}   attr    name    login
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     SIGUIENTE

03_0014_LOGIN_Visualizar_objeto_boton_Cancelar
    [Tags]
    #Verificar si el objeto cancel se muestra en la pantalla
    ${element}=     Element identifier      attr    name    cancel
    Verify is screen loaded     ${element}

03_0015_LOGIN_Verificar_texto_boton_cancelar_contiene_el_texto_Cancelar
    [Tags]
    Wait until      attr    name    cancel
    ${Node}         Get element by parentData   attr    bounds    {8, 8, 464, 32}   attr    name    cancel
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     CANCELAR

03_0019_Verificar_funcionalidad_boton_cancelar
    [Tags]
    Wait until      attr    name    cancel
    #Seleccionar boton Cancelar
    Send Key    Down
    Send Key    Down
    Send key    Down
    Send Key    Select
    #Verificar si el elemento poster se visualiza en la landing
    ${element}=     Element identifier  attr    name    fondo
    Verify is screen loaded     ${element}

03_0020_LOGIN_Visualizar_objeto_boton_Nuevo_en_Claro_video_Registrate
    [Tags]
   #Verificar si el objeto toRegister se muestra en la pantalla
    ${element}=     Element identifier      attr    name    toRegister
    Verify is screen loaded     ${element}

03_0044_LOGIN_Verificar_inicio_de_sesion_exitoso
    [Tags]      CriticalRoute       a
    #Seleeccionar input "Usuario"
    Send key    Select
    Send key    Select
    #Ingresar usuario
    Enter username      ${userMail_NoRents}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña
    Enter password    ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si el elemento "Menú" del menú provisorio se visualiza en pantalla
    ${element}=     Element identifier by text   text   Menú
    Verify is screen loaded     ${element}
    [Teardown]  Logout teardown

03_0041_LOGIN_Error_en_correo_electronico_no_registrado
    [Tags]      Negative    Incomplete
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario no valido
    Enter username    ${userNotRegistered}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña
    Enter password      ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded     ${element}

03_0042_LOGIN_Error_en_formato_en_ingreso_de_contrasenia
    [Tags]      Negative    Incomplete
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario
    Enter username    ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña no valida
    Enter password      ${passNotValid}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded     ${element}

Login with an invalid user and password
    [Tags]      Negative    Incomplete
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario no valido
    Enter username      ${userNotValid}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña no valida
    Enter password      ${passNotValid}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded   ${element}

Login with empty password
    [Tags]      Negative    Incomplete
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario
    Enter username      ${userMail}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded     ${element}

Login with empty user
    [Tags]      Negative    Incomplete
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña
    Enter password      ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded     ${element}

Login with empty user and password
    [Tags]      Negative    Incomplete
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Down
    Send key    Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=     Element identifier      attr    name    error
    Verify is screen loaded     ${element}

03_0047_LOGIN_Reabrir_canal_con_sesion_activa
    [Tags]      Critical
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario
    Enter username      ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña
    Enter password      ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Seleccionar botón "Home" en el control remoto
    Send key    Home
    #Abrir el canal
    Launch the channel      ${channel_code}
    #Verificar si el elemento "Menú" del menú provisorio se visualiza en pantalla
    ${element}=     Element identifier by text   text   Menú
    Verify is screen loaded     ${element}
    [Teardown]  Logout teardown

Logout
    [Tags]      CriticalRoute
    [Setup]     Access and login
    Send key    Info
    Send key    Down
    Send key    Select
    ${element}=     Element identifier  attr    name    btnLogin
    Verify is screen loaded     ${element}





