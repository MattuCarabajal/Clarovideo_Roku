*** Settings ***
Documentation   Suite Login
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

*** Variables ***


*** Test Cases ***
#Setup
Channel is launched
    Side load  ${sideload}   rokudev   1234
    #Verificación
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Access the login
    Comment   Entrar al usuario
    Send key  Select  1
    Send key  Select  1
    Comment   Ingresar el usuario
    Enter username   ${userMail}
    Comment   Entrar en contraseña
    Send key  Down   1
    Send key  Select  1
    Comment
    Enter password   ${pass}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

Logout
    Send key  Right   1
    Set press delay   1000
    Send key  Right   1
    Send key  Right   1
    Send key  Right   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Login with an invalid user
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userNotValid}

    Send key  Down   1
    Send key  Select  1

    Enter password   ${pass}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Login with an invalid password
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userNotValid}

    Send key  Down   1
    Send key  Select  1

    Enter password   ${passNotValid}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Login with an invalid user and password
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userNotValid}

    Send key  Down   1
    Send key  Select  1

    Enter password   ${passNotValid}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Login with empty password
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userMail}

    Send key  Down   1
    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Login with empty user
    Send key  Select  1
    Send key  Down   1
    Send key  Select  1

    Enter password   ${pass}

    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Login with empty user and password
    Send key  Select  1
    Send key  Down   1
    Send key  Down   1
    Send key  Select  1

    ${element}=   Element identifier   attr   name   error
    Verify is screen loaded   ${element}
    Exit error message

Reopen with active sesion
    Send key  Select  1
    Send key  Select  1

    Enter username   ${userMail}

    Send key  Down   1
    Send key  Select  1

    Enter password   ${pass}

    Send key  Down   1
    Send key  Select  1

    Send key  Home
    Launch the channel   dev

    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

*** Keywords ***
Exit error message
    Send key  Select  1
    Send key  Down   1
    Send key  Select  1

