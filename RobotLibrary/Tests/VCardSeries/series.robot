*** Settings ***
Documentation   Suite Series
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel and login
Test Setup      Open channel
Test Teardown   Run if fails
Suite Teardown  Reabrir y logout

*** Test Cases ***
Reproducir_serie_con_inicio_sesion
    [Tags]      CriticalRoute   Incompleto
    #Ubicar y seleccionar serie
    Send key    Right
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player
    Verify is playback started
    [Teardown]  Teardown player

Reproducir_serie_con_registro
    [Tags]      CriticalRoute   Incompleto
    [Setup]     Access and Register
    #Ubicar y seleccionar serie
    Send key    Right
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