*** Settings ***
Library   BuiltIn

*** Keywords ***
Launch channel
    Side load  ${sideload}   ${channel_code}   ${channel_pass}
    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

Login
    Comment   Ubicar y seleccionar botón "Inicia Sesion"
    Send key  Down   1
    Send key  Select  1
    Comment   Seleeccionar input "Usuario"
    Send key  Select  1
    Comment   Ingresar usuario
    Enter username   ${userMail}
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

Access Login
    Open channel
    Send Key   Down
    Send Key   Select
