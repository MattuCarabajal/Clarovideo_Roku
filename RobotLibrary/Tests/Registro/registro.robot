*** Settings ***
Documentation   Suite Registro
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Test Setup       Launch channel
Test Setup       Launch The Channel   ${channel_code}

*** Test Cases ***
02_0001_REGISTRO_Visualizar_objeto_Registrate
    Comment   Seleccionar botón "Registrate"
    Sleep   3
    Send key   Select
    Comment   Verificar si el elemento título se visualiza en pantalla
    ${element}=   Element identifier   attr   name   title
    Verify is screen loaded   ${element}
