*** Settings ***
Documentation   Suite Movies
Variables       ./../../Library/variables.py
Library        ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Suite Setup    Launch channel
Suite Setup     Access and login
Test Teardown   Run if fails

*** Test Cases ***
Reproducir_película_con_inicio_sesion
    [Tags]  RutaCritica
    #Ubicar y seleccionar película
    Send key    Select
    Send key    Select
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player

    [Teardown]  Logout Teardown

Reproducir_película_con_registro
    [Tags]  RutaCritica
    #Ubicar y seleccionar película
    Send key    Select
    Send key    Select
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player





