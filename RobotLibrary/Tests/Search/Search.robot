*** Settings ***
Documentation   Suite Search
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
#Suite Setup     Launch channel
#Suite Setup     Launch channel and login
#Test Setup      Access the search
#Test Teardown   Run if fails

*** Test Cases ***

05_0002_BUSCADOR_Verificar_texto_buscador
    [Tags]
    ${text}=        Element identifier by text    text    Búsqueda
    Verify is screen loaded    ${text}

05_0013_BUSCADOR_Verificar_objeto_mensaje_contenido_no_encontrado_contenga_el_texto_no_econtrado_en_negritas
    [Tags]
    Send NotResults
    ${element}=     Element identifier by text   text    Lo sentimos. Parece que no hay coincidencias para: SAML.\n\nUtiliza otras palabras clave, busca el nombre del actor o director o prueba con un género.
    Verify is screen loaded     ${element}





