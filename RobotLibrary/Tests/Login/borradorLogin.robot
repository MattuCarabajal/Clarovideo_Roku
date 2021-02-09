*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
#Library   ./../../Library/test_library.py
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Probando Setup
Test Setup       Launch channel

*** Variables ***


*** Test Cases ***
Get value from attribute

    ${text}=   Get attr   attr   name   title   text
    Assert Equal   ${text}   ¡Todo lo que te gusta en un sólo lugar!

*** Keywords ***
Exit error message
    Send key   Select   1
    Send key   Down   1
    Send key   Select   1
