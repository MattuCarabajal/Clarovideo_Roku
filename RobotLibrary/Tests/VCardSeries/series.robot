*** Settings ***
Documentation   Suite Series
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
Reproducir_serie
    #Acceder a la serie desHECHO EN CASA
    Send key    Select
    #Acceder a Episodes
    Send key    Select
    #Acceder al primer episodio Desde Casa
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player