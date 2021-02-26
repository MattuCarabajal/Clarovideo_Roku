*** Settings ***
Documentation   Test Execution Example
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

*** Test Cases ***
First test executed
    #Instalar aplicación
    Side load       ${sideload}     ${roku_user}     ${roku_pass}
    #Verificar que se cargó un elemento de la landing
    ${element}=     Element identifier      attr    name    btnLogin
    Verify is screen loaded     ${element}
