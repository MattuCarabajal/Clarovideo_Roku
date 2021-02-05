*** Keywords ***
Launch channel
    Side load  ${sideload}   rokudev   1234

    ${element}=   Element identifier   attr   name   btnLogin
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