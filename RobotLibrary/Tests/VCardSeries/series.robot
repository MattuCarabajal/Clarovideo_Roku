*** Settings ***
Documentation   Suite Series
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

Suite Setup     Launch channel
Test Setup      Access and login
Test Teardown   Run if fails


*** Test Cases ***
Reproducir_serie_con_inicio_sesion
    [Tags]      CriticalRoute
    #Acceder a la serie El Continental
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player
    Verify is playback started
    [Teardown]  Teardown player

Reproducir_serie_con_registro
    [Setup]     Access and Register
    [Tags]      CriticalRoute
    #Acceder a la serie El Continental
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player
    Verify is playback started
    [Teardown]  Back player

*** Keyword ***
Teardown player
    Run if fails
    Send key    back
    Logout teardown

Back player
    Run if fails
    Send key    back