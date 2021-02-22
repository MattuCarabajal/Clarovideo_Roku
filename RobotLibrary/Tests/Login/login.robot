*** Settings ***
Documentation   Suite Login
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Suite Setup         Launch channel
Test Setup          Access login
Test Teardown       Si falla Screenshot
Suite Teardown       Logout

*** Test Cases ***
03_0001_LOGIN-Visualizar_objeto_titulo_Inicia_sesion
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=   Element identifier   attr   name   title
    Verify is screen loaded   ${element}

03_0002_LOGIN_Verificar_texto_Inicia_sesion
    #Verificar que el objeto título contenga el texto "Inicia sesión"
    ${text}=   Get attr   attr   name   title   text
    Assert Equal   ${text}   Inicia sesión

03_0004_LOGIN_Visualizar_objeto_descripcion_Cual_es_tu_correo_electronico
    #Verificar si el elemento descrip se visualiza en pantalla
    ${element}=   Element identifier   attr   name   descrip
    Verify is screen loaded   ${element}

03_0005_LOGIN_Verificar_objeto_descripción_contiene_texto_Cual_es_tu_correo_electronico
    #Verificar que el objeto descrip contenga el texto "¿Cuál es tu correo electrónico?"
    ${text}=   Get attr   attr   name   descrip   text
    Assert Equal   ${text}   ¿Cuál es tu correo electrónico?

Login with an invalid user
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario no valido
    Enter username   ${userNotRegistered}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar Contrasenia
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Login with an invalid password
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar Contrasenia no valida
    Enter password   ${passNotValid}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Login with an invalid user and password
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario no valido
    Enter username   ${userNotRegistered}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar Contrasenia no valida
    Enter password   ${passNotValid}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Login with empty password
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Login with empty user
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar Contrasenia
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Login with empty user and password
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

Reopen with active sesion
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar Contrasenia
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Seleccionar botón "Home" en el control remoto
    Send key  Home
    #Abrir el canal
    Launch the channel   ${channel_code}
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
    ${element}=   Element identifier by text    text    Opciones
    Verify is screen loaded   ${element}

#Logout
#    Send key    *
#    Send key    Select
#    ${element}=   Element identifier   attr   name   btnLogin
#    Verify is screen loaded   ${element}

#Access the login
    #Seleeccionar input "Usuario"
#    Send key  Select
    #Ingresar usuario
#    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
#    Send key  Down
#    Send key  Select
    #Ingresar Contrasenia
#    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
#    Send key  Down
#    Send key  Select
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
#    ${element}=   Element identifier by text    text    Opciones
#    Verify is screen loaded   ${element}
