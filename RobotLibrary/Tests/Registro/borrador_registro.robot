*** Settings ***
Documentation   Suite Registro
Variables       ./../../Library/variables.py
Library     ./../../Library/RobotLibrary.py     ${ip_address}   ${timeout}  ${pressDelay}   ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Suite Setup    Launch channel
Test Setup      Open channel
#Test Teardown   Run if fails
Suite Teardown  Logout

*** Test Cases ***
02_0001_REGISTRO_Visualizar_objeto_Registrate
    [Tags]  CriticalRoute   Sprint2
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=   Element identifier   attr   name   title
    Verify is screen loaded   ${element}

02_0002_REGISTRO_Visualizar_texto_Registrate
    [Tags]  Critical     Sprint2
    #Verificar si el texto Registro se visualiza en pantalla
    ${text}=   Get attr    attr   name   title   text
    Assert Equal   ${text}  Regístrate

02_0019_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_agregar_un_mail
    [Tags]  CriticalRoute   Sprint1     Critical
    Send key            Down

*** Keyword ***
Run if fails
    Run Keyword If Test Failed    Screenshot    ${CURDIR}   ${TEST NAME}    ${roku_user}    ${roku_pass}