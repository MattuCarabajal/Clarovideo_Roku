*** Settings ***
Documentation   Suite Launch channel
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

Test Teardown       Run if fails

*** Test Cases ***
Channel is launched
    #Sidelodear canal
    Side load   ${sideload}     ${roku_user}    ${roku_pass}
    #Verificar que accedio a la landing del canal
    ${element}=     Element identifier    attr   name   btnLogin
    Verify is screen loaded     ${element}
