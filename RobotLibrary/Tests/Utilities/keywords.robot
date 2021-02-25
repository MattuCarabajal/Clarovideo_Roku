*** Settings ***
Library   BuiltIn

*** Keywords ***
Run if fails
    Run Keyword If Test Failed    Screenshot    ${EXECDIR}  ${TEST NAME}    ${roku_user}    ${roku_pass}

Launch channel
    Side load  ${sideload}   ${roku_user}   ${roku_pass}
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Login
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username      ${userMail}
    Comment   Ubicar y seleccionar input "Password"
    Send key  Down   1
    Send key  Select  1
    Comment   Ingresar contraseña
    Enter password   ${pass}
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Verificar si el elemento "Salir" del menú provisorio se visualiza en pantalla
    ${element}=   Element identifier   attr   name   m5
    Verify is screen loaded   ${element}

Register
    #Seleccionar campo mail
    Send key   Select
    #Introducir mail
    ${mailcreate}=   Create mail
    Enter username    ${mailcreate}
    #Seleccionar campo Contrasenia
    Send Key   Down
    Send Key   Select
    #Introducir Contrasenia
    Enter password    ${passValid}
    #Aceptar Terminos y condiciones
    Send Key   Down
    Send Key   Select
    #Seleccionar Siguiente
    Send Key   Down
    Send Key   Select

Element identifier
    [Arguments]   ${usingValue}   ${attributeValue}   ${valueValue}
    ${using}   Set Variable   using
    ${attribute}   Set Variable   attribute
    ${value}   Set Variable   value
    &{usingDic}=   Create dictionary   ${using}=${usingValue}   ${attribute}=${attributeValue}   ${value}=${valueValue}
    @{elementsDic}=   Create List   ${usingDic}
    &{ElementParams}   Create dictionary   elementData=${elementsDic}
    [Return]   &{ElementParams}

Enter username
    [Arguments]     ${userMail}
    ${userArray}=   Convert mail    ${userMail}
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

Enter password
    [Arguments]  ${passWord}
    Send word  ${passWord}
    Send key  Down   1
    Send key  Down   1
    Send key  Down   1
    Send key  Down   1
    Send key  Select  1

Exit error message
    Send key   Select   1
    Send key   Down   1
    Send key   Select   1

Element identifier by text
    [Arguments]   ${usingValue}   ${valueValue}
    ${using}   Set Variable   using
    ${value}   Set Variable   value
    &{usingDic}=   Create dictionary   ${using}=${usingValue}   ${value}=${valueValue}
    @{elementsDic}=   Create List   ${usingDic}
    &{ElementParams}   Create dictionary   elementData=${elementsDic}
    [Return]   &{ElementParams}

Get attr
    [Arguments]   ${using}   ${attribute}   ${value}   ${returnValueOfAttrubyte}
    &{element}=   Element identifier   ${using}   ${attribute}   ${value}
    &{element}=   Get element   ${element}
    ${attributeValue}=   Get attribute   ${element}   ${returnValueOfAttrubyte}
    [Return]   ${attributeValue}

Assert Equal
    [Arguments]   ${value}   ${reference}
    ${result}   Should Be Equal   ${value}   ${reference}
    [Return]   ${result}

Open channel
    Launch the channel   ${channel_code}
    Sleep   3

Access Registration
    Open channel
    Send key   Select

Access and Register
    Access Registration
    Register

Access Login
    Open channel
    Send Key   Down
    Send Key   Select

Access and login
    Access Login
    Login

Logout
    Send key    Info
    Send key    Select
    Send key    Select

Logout teardown
    Run if fails
    Logout

Reabrir Canal
    Send key        home
    Open channel