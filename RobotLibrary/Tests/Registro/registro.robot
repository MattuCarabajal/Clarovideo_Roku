*** Settings ***
Documentation   Suite Registro
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel
Test Setup      Access Registration
Test Teardown   Run if fails

*** Test Cases ***
02_0001_REGISTRO_Visualizar_objeto_Registrate
    #Verificar si el elemento título se visualiza en pantalla
    ${element}=     Element identifier      attr    name    title
    Verify is screen loaded     ${element}

02_0002_REGISTRO_Visualizar_texto_Registrate
    #Verificar si el texto Registro se visualiza en pantalla
    ${text}=    Get attr    attr     name    title    text
    Assert Equal   ${text}  Regístrate

02_0003_REGISTRO_Visualizar_objeto_titulo_Cual_es_tu_correo_electronico
    [Tags]          NotCritical     Sprint5
    #Verificar si el elemento descripción se visualiza en pantalla
    ${element}=     Element identifier      attr    name    descrip
    Verify is screen loaded     ${element}

02_0004_REGISTRO_Visualizar_texto_Cual_es_tu_correo_electronico
    [Tags]          NotCritical     Sprint5      ApaText
    #Esperar a que el elemento descrip aparezca en pantalla
    Wait until      attr        name        descrip
    #Verificar si el elemento descript contiene el texto ¿Cuál es tu correo electrónico? se visualiza en pantalla
    ${text}=    Get attr    attr     name    descrip    text
    Assert Equal   ${text}  ¿Cuál es tu correo electrónico?

02_0005_REGISTRO_Validar_placeholder_correo_electronico
    [Tags]          NotCritical     Sprint5      ApaText
    #Esperar a que el elemento user aparezca en pantalla
    Wait until      attr    name    user
    #Verificar si el elemento user contiene el texto Correo electrónico
    ${Node}         Get element by parentData   attr    bounds    {24, 11, 432, 26}   attr    name    user
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     Correo electrónico

02_0006_REGISTRO_Verificar_placeholder_del_campo_contrasenia_en_la_pantalla_de_registro
    [Tags]          NotCritical     Sprint5      ApaText
    #Esperar a que el elemento pass aparezca en pantalla
    Wait until      attr    name    pass
    #Verificar si el elemento pass contiene el texto Contraseña
    ${Node}         Get element by parentData   attr    bounds    {24, 11, 432, 26}   attr    name    pass
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     Contraseña

02_0007_REGISTRO_Visualizar_objeto_boton_Siguiente
    [Tags]          NotCritical     Sprint5
    #Esperar a que el elemento register aparezca en pantalla
    Wait until      attr    name    register
    #Verificar si el elemento register se visualiza en pantalla
    ${element}=     Element identifier      attr    name    register
    Verify is screen loaded     ${element}

02_0008_REGISTRO_Verificar_texto_botón_siguiente_contiene_el_texto_Siguiente
    [Tags]          NotCritical     Sprint5      ApaText
    #Esperar a que el elemento register aparezca en pantalla
    Wait until      attr    name    register
    #Verificar si el elemento register contiene el texto SIGUIENTE
    ${Node}         Get element by parentData   attr    bounds    {8, 8, 464, 32}   attr    name    register
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     SIGUIENTE

02_0009_REGISTRO_Verificar_color_de_texto_del_boton_siguiente
    [Tags]          NotCritical     Sprint5
    #Esperar a que el elemento register aparezca en pantalla
    Wait until      attr    name    register
    #Verificar si el texto del elemento register es de color blanco
    ${Node}         Get element by parentData   attr    text    SIGUIENTE   attr    name    register
    ${Value}        Get attr by ParentData     ${Node}      color
    #Hay que poner una barra invertida \ antes del # para escapar a la funcion comentario
    Assert Equal    ${Value}     \#ffffffff

02_0012_REGISTRO_Verificar_funcionalidad_del_boton_cancelar
    [Tags]          NotCritical     Sprint5
    #Esperar a que el elemento cancel aparezca en pantalla
    Wait until      attr    name    cancel
    #Ubicar y seleccionar boton cancel
    Send key    Down
    Send key    Down
    Send key    Down
    Send key    Down
    Send key    Select
    #Esperar a que el elemento btnLogin aparezca en pantalla
    Wait until      attr    name    btnLogin
    #Verificar si el elemento btnLogin se visualiza en pantalla
    ${element}=     Element identifier      attr    name    btnLogin
    Verify is screen loaded     ${element}

02_0013_REGISTRO_Verificar_texto_boton_cancelar_contiene_el_texto
    [Tags]          NotCritical     Sprint5      ApaText
    #Esperar a que el elemento cancel aparezca en pantalla
    Wait until      attr    name    cancel
    #Verificar si el elemento cancel contiene el texto CANCELAR
    ${Node}         Get element by parentData   attr    bounds    {8, 8, 464, 32}   attr    name    cancel
    ${Value}        Get attr by ParentData     ${Node}      text
    Assert Equal    ${Value}     CANCELAR

02_0014_REGISTRO_Verificar_color_de_texto_del_boton_cancelar
    [Tags]          NotCritical     Sprint5
    #Esperar a que el elemento cancel aparezca en pantalla
    Wait until      attr    name    cancel
    #Verificar si el texto del elemento register es de color blanco
    ${Node}         Get element by parentData   attr    text    CANCELAR   attr    name    cancel
    ${Value}        Get attr by ParentData     ${Node}      color
    #Hay que poner una barra invertida \ antes del # para escapar a la funcion comentario
    Assert Equal    ${Value}     \#ffffffff

02_0017_REGISTRO_Verificar_objeto_titulo_Registrate_en_la_pantalla_de_ingreso_de_correo_eletronico
    [Tags]          NotCritical     Sprint5
    #Esperar a que el elemento user aparezca en pantalla
    Wait until      attr    name    user
    #Seleccionar input user
    Send key    Select
    ${element}=     Element identifier      attr    name    toLogin
    Verify is screen loaded     ${element}

02_0038_REGISTRO_Verificar_error_al_intentar_registrarse_con_campos_usuario_y_contrasenias_vacios
    [Tags]      Negative    Incomplete
    #No se ingresa un mail
    #No se ingresa una contrasenia
    #Buscar y aceptar Terminos y condiciones
    Send key            Down
    Send key            Down
    Send key            Select
    #Ubicar y seleccionar botón "Siguiente"
    Send key            Down
    Send key            Select
    #Verificar si la pantalla de error "Error ¡Lo sentimos!" se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0047_REGISTRO_Verificar_el_correcto_registro_con_datos_validos
    [Tags]      CriticalRoute
    #Seleccionar campo mail
    Send key        Select
    #Introducir mail
    ${mailcreate}=      Create mail
    Enter username      ${mailcreate}
    #Seleccionar campo Contrasenia
    Send Key        Down
    Send Key        Select
    #Introducir Contrasenia
    Enter password  ${passValid}
    #Aceptar Terminos y condiciones
    Send Key        Down
    Send Key        Select
    #Seleccionar Siguiente
    Send Key        Down
    Send Key        Select
    #Verificar si entro a la home
    ${texto}        Element identifier by text      text    Menú
    Verify is screen loaded     ${texto}
    [Teardown]      Logout teardown

02_0033_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_agregar_un_mail
    [Tags]          Negative     Sprint5
    #Ubicar y seleccionar campo Contrasenia
    Send Key        Down
    Send Key        Select
    #Introducir Contrasenia
    Enter password  ${passValid}
    #Aceptar Terminos y condiciones
    Send Key        Down
    Send Key        Select
    #Seleccionar Siguiente
    Send Key        Down
    Send Key        Select
    #Esperar a que el elemento error aparezca en pantalla
    Wait until      attr    name    error
    #Verificar si la pantalla de error (Falta mensaje de error)  se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0034_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_tildar_terminos_y_condiciones
    [Tags]          Negative     Sprint5
    #Seleccionar input "Correo electrónico"
    Send key            Select
    #Ingresar Correo electrónico
    Enter username      ${ValidMailForErrors}
    #Ubicar y seleccionar campo Contrasenia
    Send Key        Down
    Send Key        Select
    #Introducir Contrasenia
    Enter password  ${passValid}
    #Buscar y seleccionar Siguiente
    Send Key        Down
    Send Key        Down
    Send Key        Select
    #Esperar a que el elemento error aparezca en pantalla
    Wait until      attr    name    error
    #Verificar si la pantalla de error (Falta mensaje de error)  se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0035_REGISTRO_Verificar_el_error_al_intentar_registrarse_sin_agregar_una_contrasenia
    [Tags]          Negative     Sprint5
    #Seleccionar input "Correo electrónico"
    Send key            Select
    #Ingresar Correo electrónico
    Enter username      ${ValidMailForErrors}
    #Buscar y aceptar Terminos y condiciones
    Send Key        Down
    Send Key        Down
    Send Key        Select
    #Seleccionar Siguiente
    Send Key        Down
    Send Key        Select
    #Esperar a que el elemento error aparezca en pantalla
    Wait until      attr    name    error
    #Verificar si la pantalla de error (Falta mensaje de error)  se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}

02_0036_REGISTRO_Verificar_que_se_pueda_tildar_el_checkbox_de_terminos_y_condiciones
    [Tags]          Negative    Sprint5        Incomplete
    #Buscar y aceptar Terminos y condiciones
    Send Key        Down
    Send Key        Down
    Send Key        Select
    #Verificar si el texto del elemento check está seleccionado
    #No encuentra el elemento...
    ${Node}         Get element by parentData   attr    uri    pkg:/images/Check_HD.png   attr    name    check
    ${Value}        Get attr by ParentData     ${Node}      visible
    Assert Equal    ${Value}     false

02_0037_REGISTRO_Verificar_el_error_al_intentar_registrarse_con_todos_los_campos_vacios
    [Tags]          Negative     Sprint5
    #Buscar y seleccionar Siguiente
    Send Key        Down
    Send Key        Down
    Send Key        Down
    Send Key        Select
    #Esperar a que el elemento error aparezca en pantalla
    Wait until      attr    name    error
    #Verificar si la pantalla de error (Falta mensaje de error)  se visualiza
    ${element}=     Element identifier      attr     name    error
    Verify is screen loaded     ${element}
