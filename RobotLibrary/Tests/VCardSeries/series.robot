*** Settings ***
Documentation   Suite Series
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Suite Setup   Launch channel
Test Setup    Access and login

*** Test Cases ***
Reproducir_serie_con_inicio_sesion
    [Tags]  RutaCritica     Critical    Incompleto
    #Acceder a la serie desHECHO EN CASA
    Send key    Select
    #Acceder a Episodes
    Send key    Select
    #Acceder al primer episodio Desde Casa
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player
    Verify is playback started
    [Teardown]  Logout Teardown

Reproducir_serie_con_registro
    [Setup] Access and Register
    #Acceder a la serie desHECHO EN CASA
    Send key    Select
    #Acceder a Episodes
    Send key    Select
    #Acceder al primer episodio Desde Casa
    Send key    Select
    #Seleccionar Play
    Send key    Select
    #Verificar si accedió al player








