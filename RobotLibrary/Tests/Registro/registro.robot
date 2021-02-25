*** Settings ***
Documentation   Suite Registro
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel
Test Setup      Access Registration
Test Teardown   Run if fails

*** Test Cases ***
02_0001_REGISTRO_Visualizar_objeto_Registrate
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=     Element identifier      attr    name    title
    Verify is screen loaded     ${element}

02_0002_REGISTRO_Visualizar_texto_Registrate
    #Verificar si el texto Registro se visualiza en pantalla
    ${text}=    Get attr    attr     name    title    text
    Assert Equal   ${text}  Regístrate

02_0019_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_agregar_un_mail
    [Tags]      Negative    Imcompleto
    #No se ingresa un mail
    #Ubicar y seleccionar input "Password"
    Send key            Down
    Send key            Select
    #Ingresar Contrasenia
    Enter password      ${passValid}
    #Buscar y aceptar Terminos y condiciones
    Send key            Down
    Send key            Select
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error ¡Lo sentimos!" se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0022_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_agregar_una_contrasenia
    [Tags]      Negative    Imcompleto
    #Seleccionar input "Correo electrónico"
    Send key            Select
    #Ingresar Correo electrónico
    Enter username      ${ValidMailForErrors}
    #No se ingresa una contrasenia
    #Buscar y aceptar Terminos y condiciones
    Send key            Down
    Send key            Down
    Send key            Select
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error ¡Lo sentimos!" se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0021_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_tildar_terminos_y_condiciones
    [Tags]      Negative    Imcompleto
    #Seleccionar input "Correo electrónico"
    Send key            Select
    #Ingresar Correo electrónico
    Enter username      ${ValidMailForErrors}
    #Ubicar y seleccionar input "Password"
    Send key            Down
    Send key            Select
    #Ingresar Contrasenia
    Enter password      ${passValid}
    #No se aceptan los Términos y Condiciones
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error (!) No aceptó los Términos y Condiciones." se visualiza
    ${element}=     Element identifier      attr    name   error
    Verify is screen loaded     ${element}

02_0024_REGISTRO_Verificar_el_error_al_intentar_registrarse_con_todos_los_campos_vacios
    [Tags]      Negative    Imcompleto
    #No se ingresa un mail
    #No se ingresa una contrasenia
    #No se aceptan los Términos y Condiciones
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Down
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error (!) No aceptó los Términos y Condiciones." se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0030_REGISTRO_Verificar_error_al_intentar_registrarse_con_campos_usuario_y_contrasenias_vacios
    [Tags]      Negative    Imcompleto
    #No se ingresa un mail
    #No se ingresa una contrasenia
    #Buscar y aceptar Terminos y condiciones
    Send key            Down
    Send key            Down
    Send key            Select
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error ¡Lo sentimos!" se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0029_REGISTRO_Verificar_el_correcto_registro_con_datos_validos
    [Tags]      CriticalRoute
    #Seleccionar campo mail
    Send key        Select
    #Introducir mail
    ${mailcreate}=      Create mail
    Enter username      ${mailcreate}
    #Seleccionar campo Contrasenia
    Send Key        Down
    Send Key        Select
    #Introducir Contrasenia
    Enter password  ${passValid}
    #Aceptar Terminos y condiciones
    Send Key        Down
    Send Key        Select
    #Seleccionar Siguiente
    Send Key        Down
    Send Key        Select
    #Verificar si entro a la home
    ${texto}        Element identifier by text      text    Opciones
    Verify is screen loaded     ${texto}
    [Teardown]      Logout teardown