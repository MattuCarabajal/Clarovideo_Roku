*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
#Library   ./../../Library/test_library.py
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

Test Setup       Launch channel

*** Variables ***


*** Test Cases ***
Access the login
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userMail}

    Send key  Down   1
    Send key  Select  1

    Enter password   ${pass}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

*** Keywords ***
Exit error message
    Send key   Select   1
    Send key   Down   1
    Send key   Select   1

Enter username
    [Arguments]  ${userMail}
    ${userArray}=   Convert mail   ${userMail}
    ${user}= 	Get From List 	${userArray} 	0
    ${mail}= 	Get From List 	${userArray} 	1
    Send word  ${user}
    Send key  Lit_%40
    Send word   ${mail}

    Send key  Down   1
    Send key  Down   1
    Send key  Down   1
    Send key  Down   1
    Send key  Select  1