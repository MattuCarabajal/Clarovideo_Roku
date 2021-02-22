*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

Test Setup          Access login
#Test Teardown       Si falla Screenshot

*** Variables ***


*** Test Cases ***
#03_0007_LOGIN_Verificar_placeholder_de_correo_electronico
    #Verificar que el placeholder del input "Correo electrónico" sea "Correo electrónico"
    #${text}=   Get attr   attr   name   user   text
    #Assert Equal   ${text}   Correo electrónico

Open menu
    Sleep 5
    Send key    *
