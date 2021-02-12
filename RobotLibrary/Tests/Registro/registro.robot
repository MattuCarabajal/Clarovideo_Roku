*** Settings ***
Documentation   Suite Registro
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

Test Setup    Access Registration


*** Test Cases ***

02_0001_REGISTRO_Visualizar_objeto_Registrate
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=   Element identifier   attr   name   title
    Verify is screen loaded   ${element}


#No funka bien
02_0002_REGISTRO_Visualizar_texto_Registrate
    #Verificar si el texto Registro se visualiza en pantalla
    ${text}=   Get attr    attr   name   title   text
    Assert Equal   ${text}  Regístrate


02_0029_REGISTRO_Verificar_el_correcto_registro_con_datos_validos
    #Seleccionar campo mail
    Send key   Select
    #Introducir mail
    ${mailcreate}=   Create mail
    Enter username    ${mailcreate}
    #Seleccionar campo contraseña
    Send Key   Down
    Send Key   Select
    #Introducir contraseña
    Enter password    ${passvalid}
    #Aceptar Terminos y condiciones
    Send Key   Down
    Send Key   Select
    #Seleccionar Siguiente
    Send Key   Down
    Send Key   Select
    #Verificar si entro a la home
    ${texto}    Element identifier by text   text   Opciones
    Verify is screen loaded   ${texto}

