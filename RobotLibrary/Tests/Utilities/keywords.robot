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
    #Salir del mensaje de Solicitud de información
    #Al ser un elemento nativo de Roku no tenemos acceso al ID ni nada como para hacer una espera dinámica
    Sleep       3
    Send Key    Select
    #Login
    #Seleeccionar input "Usuario"
    Send key    Select  1
    #Ingresar usuario
    Enter username      ${userMail}
    #Ubicar y seleccionar input "Password"
    Send key    Down   1
    Send key    Select  1
    #Ingresar contraseña
    Enter password      ${pass}
    #Ubicar y seleccionar botón "Inicia Sesion"
    Send key    Down   1
    Send key    Select  1

Launch channel and login
    Side load  ${sideload}   ${roku_user}   ${roku_pass}
    ${element}=   Element identifier    attr    name    btnLogin
    Verify is screen loaded   ${element}
    Access Login
    Login

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

Launch channel and register
    Side load  ${sideload}   ${roku_user}   ${roku_pass}
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}
    Register

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
    Launch the channel  ${channel_code}
    Wait until text     text    Claro video te recomienda
    #Sleep   7

Open channel not logged
    Launch the channel   ${channel_code}
    Wait until      attr    name    btnLogin

Access Registration
    Open channel not logged
    Send key   Select

Access and Register
    Access Registration
    Register
    Wait until text     text    Claro video te recomienda
    #Sleep   7

Access Login
    Open channel not logged
    Send Key   Down
    Send Key   Select

Access and login
    Access Login
    Login
    Wait until text     text    Claro video te recomienda
    #Sleep   7

Logout
    Send key    Info
    Set press delay     2
    Send key    Down
    Send key    Select

Logout teardown
    Sleep               3
    Wait until text     text    Opciones
    Run if fails
    Logout

Reabrir Canal
    Send key        home
    Open channel

Wait until
    [Arguments]     ${usingValue}   ${attributeValue}   ${valueValue}
    ${element}=     Element identifier      ${usingValue}   ${attributeValue}   ${valueValue}
    Verify is screen loaded     ${element}      ${wait}

Wait until text
    [Arguments]   ${usingValue}   ${valueValue}
    ${element}=     Element identifier by text      ${usingValue}   ${valueValue}
    Verify is screen loaded     ${element}      ${wait}

Reabrir y logout
    Reabrir Canal
    Logout

Get element by parentData
    [Arguments]   ${usingValue}   ${attributeValue}   ${valueValue}     ${usingParentValue}   ${attributeParentValue}   ${valueParentValue}
    ${using}   Set Variable   using
    ${attribute}   Set Variable   attribute
    ${value}   Set Variable   value

    &{usingDic}=   Create dictionary   ${using}=${usingValue}   ${attribute}=${attributeValue}   ${value}=${valueValue}
    @{elementsDic}=   Create List   ${usingDic}

    &{usingDic}=   Create dictionary   ${using}=${usingParentValue}   ${attribute}=${attributeParentValue}   ${value}=${valueParentValue}
    @{elementsParentDic}=   Create List   ${usingDic}

    &{DicNode}      Create dictionary       elementData=${elementsDic}   parentData=${elementsParentDic}
    [Return]   &{DicNode}

Get attr by ParentData
    [Arguments]     ${DicNode}      ${returnValueOfAttrubyte}
    &{element}=   Get element   ${DicNode}
    ${attributeValue}=   Get attribute   ${element}   ${returnValueOfAttrubyte}
    [Return]   ${attributeValue}

#Search

Access the search
    Send key    Info
    Set press delay     2
    Send key    Select

Send sam
    Send key    down
    Send key    select
    Send key    up
    Send key    select
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    select

Send NotResults
    Send key    down
    Send key    select
    Send key    up
    Send key    select
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    left
    Send key    select
    Send key    left
    Send key    select