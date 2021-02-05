*** Settings ***
Documentation  Basic smoke tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

*** Variables ***


*** Test Cases ***
Channel is launched
    Comment   Sidelodear canal
    Side load  ${sideload}   rokudev   1234
    Comment   Verificar que accedio a la landing del canal
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}


