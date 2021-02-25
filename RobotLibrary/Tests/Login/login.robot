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

03_0044_LOGIN_Verificar_inicio_de_sesion_exitoso
    [Tags]      CriticalRoute
    #Seleeccionar input "Usuario"
    Send key    Select
    #Ingresar usuario
    Enter username      ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key    Down
    Send key    Select
    #Ingresar contraseña
    Enter password    ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down
    Send key    Select
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
    ${element}=     Element identifier by text   text   Opciones
    Verify is screen loaded     ${element}
    [Teardown]  Logout teardown

03_0041_LOGIN_Error_en_correo_electronico_no_registrado
    [Tags]      Negative    Imcompleto
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
    [Tags]      Negative    Imcompleto
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
    [Tags]      Negative    Imcompleto
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
    [Tags]      Negative    Imcompleto
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
    [Tags]      Negative    Imcompleto
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
    [Tags]      Negative    Imcompleto
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
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
    ${element}=     Element identifier by text   text   Opciones
    Verify is screen loaded     ${element}
    [Teardown]  Logout teardown

Logout
    [Tags]      CriticalRoute
    [Setup]     Login
    Send key    Info
    Send key    Select
    ${element}=     Element identifier  attr    name    btnLogin
    Verify is screen loaded     ${element}
