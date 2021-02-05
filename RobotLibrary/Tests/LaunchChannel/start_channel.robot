*** Settings ***
Documentation  Basic smoke tests
Variables  ./../../Library/variables.py
Library  ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library  Collections

*** Variables ***
${channel_code}  dev
&{ElementData}=   using=attr  attribute=name  value=btnLogin
@{ElementArray}=    &{ElementData}
&{ElementParams}    elementData=${ElementArray}
${sideload}=  G:/GlobalHitss/Roku/Clarovideo_Roku/canal/rokub0.zip

*** Test Cases ***
Channel is launched
    Side load  ${sideload}   rokudev   1234
    Verify is screen loaded    ${ElementParams}


