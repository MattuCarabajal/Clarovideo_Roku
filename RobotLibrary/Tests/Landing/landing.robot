*** Settings ***
Documentation   Suite Landing
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py     ${ip_address}   ${timeout}  ${pressDelay}   ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Test Setup      Launch channel
Test Setup      Open channel
Test Teardown   Run if fails

*** Test Cases ***
01_0001_LANDING_Verificar_poster_fondo_de_pantalla
    [Tags]  Imcompleto
    ${element}=     Element identifier  attr    name    btnLogin #Buscar id elemento fondo de pantalla
    Verify is screen loaded     ${element}

#Landing's title is available


01_0004_LANDING_Visualizar_texto_todo_lo_que_te_gusta_en_un_solo_lugar
    [Tags]  ApaText
    ${text}=        Get attr    attr    name    title   text
    Assert Equal    ${text}     ¡Todo lo que te gusta en un sólo lugar!
