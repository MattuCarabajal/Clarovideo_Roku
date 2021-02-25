*** Settings ***
Documentation   Suite Movies
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel
Suite Setup     Access and login
Test Teardown   Run if fails

*** Test Cases ***
Reproducir_película
    [Tags]  Ruta_Critica
    #Ubicar y seleccionar película
    Send key    Select
    Send key    Select
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player

Reproducir_película2
    #Ubicar y seleccionar película Como si fuera la primera vez
    Send key    Right
    Send key    Right
    Send key    Select
