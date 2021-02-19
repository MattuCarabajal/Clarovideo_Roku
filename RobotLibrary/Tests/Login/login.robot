*** Settings ***
Documentation   Suite Login
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Suite Setup   Launch channel
Test Setup    Access login

*** Variables ***
&{ElementData}=     using=text  value=Opciones
@{ElementArray}=    &{ElementData}
&{ParamsOpciones}    elementData=${ElementArray}

*** Test Cases ***
03_0001_LOGIN-Visualizar_objeto_titulo_Inicia_sesion
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=   Element identifier   attr   name   title
    Verify is screen loaded   ${element}

03_0044_LOGIN_Verificar_inicio_de_sesion_exitoso
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar contraseña
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
     ${element}=   Get element ${ParamsOpciones}
    Verify is screen loaded   ${ParamsOpciones}

#Logout


03_0041_LOGIN_Error_en_correo_electronico_no_registrado
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario no valido
    Enter username   ${userNotValid}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar contraseña
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Verificar si la pantalla de error "El usuario o password son incorrectos" se visualiza
    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}

03_0042_LOGIN_Error_en_formato_en_ingreso_de_contrasenia
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar contraseña no valida
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
    Enter username   ${userNotValid}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar contraseña no valida
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
    Ingresar usuario
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
    #Ingresar contraseña
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

03_0047_LOGIN_Reabrir_canal_con_sesion_activa
    #Seleeccionar input "Usuario"
    Send key  Select
    #Ingresar usuario
    Enter username   ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key  Down
    Send key  Select
    #Ingresar contraseña
    Enter password   ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down
    Send key  Select
    #Seleccionar botón "Home" en el control remoto
    Send key  Home
    #Abrir el canal
    Launch the channel   ${channel_code}
    #Verificar si el elemento "Opciones" del menú provisorio se visualiza en pantalla
    ${element}=   Get element ${ParamsOpciones}
    Verify is screen loaded   ${ParamsOpciones}

