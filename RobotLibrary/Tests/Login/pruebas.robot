*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
Resource   ./../Utilities/keywords.robot

*** Variables ***
${channel_code}  dev
${sideload}=  G:/GlobalHitss/Roku/Clarovideo_Roku/canal/rokub0.zip
${user}=   fer_prod
${user2}=   gmail.com
#@{special}=  \@{notvar}
#${userReg}=  Replace String Using Regexp ${user}
${pass}=   123456
${userNotValid}=   fer
${passNotValid}=   123

*** Test Cases ***
Channel is launched
    Side load   ${sideload}   rokudev   1234
    Comment   Antes de entrar
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

*** Keywords ***
Element identifier
    [Arguments]   ${usingValue}   ${attributeValue}   ${valueValue}
    ${using}   Set Variable   using
    ${attribute}   Set Variable   attribute
    ${value}   Set Variable   value
    &{usingDic}=   Create dictionary   ${using}=${usingValue}   ${attribute}=${attributeValue}   ${value}=${valueValue}
    @{elementsDic}=   Create List   ${usingDic}
    &{ElementParams}   Create dictionary   elementData=${elementsDic}
    [Return]   &{ElementParams}