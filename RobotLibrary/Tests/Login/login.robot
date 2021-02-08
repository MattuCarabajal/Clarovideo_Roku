*** Settings ***
Documentation   Suite Login
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

*** Variables ***


*** Test Cases ***
#Setup
Channel is launched
    Comment   Sidelodear aplicación
    Side load  ${sideload}   rokudev   1234
    Comment   Verificar si el elemento "Inicia Sesion" de la pantalla Launch se visualiza en pantalla
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Access the login
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username   ${userMail}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña
    Enter password   ${pass}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si el elemento "Salir" del menú provisorio se visualiza en pantalla
    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

Logout
    Comment   Desplazar hasta el elemento "Salir" del menú provisorio y seleccionarlo
    Send key  Right   1
    Set press delay   1000
    Send key  Right   1
    Send key  Right   1
    Send key  Right   1
    Send key  Select  1
    Comment   Verificar si el elemento "Inicia Sesion" de la pantalla Launch se visualiza en pantalla
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Login with an invalid user
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario no valido
    Enter username   ${userNotValid}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña
    Enter password   ${pass}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Login with an invalid password
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username   ${userMail}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña no valida
    Enter password   ${passNotValid}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Login with an invalid user and password
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario no valido
    Enter username   ${userNotValid}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña no valida
    Enter password   ${passNotValid}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Login with empty password
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username   ${userMail}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Login with empty user
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña
    Enter password   ${pass}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Login with empty user and password
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Comment   Salir de la pantalla de error "El usuario o password son incorrectos"
    Exit error message

Reopen with active sesion
    Comment   Seleccionar boton "Inicia Sesion"
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username   ${userMail}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña
    Enter password   ${pass}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Seleccionar botón "Home" en el control remoto
    Send key  Home
    Comment   Abrir el canal
    Launch the channel   dev
    Comment   Verificar si el elemento "Salir" del menú provisorio se visualiza en pantalla
    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

*** Keywords ***
Exit error message
    Send key  Select  1
    Send key  Down   1
    Send key  Select  1

