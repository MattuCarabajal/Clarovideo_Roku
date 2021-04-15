*** Settings ***
Documentation   Deep Linking Input
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel and login
Test Setup      Open channel
Test Teardown   Run if fails
Suite Teardown  Reabrir y logout

*** Test Cases ***
DeepLinking_input_Acceder_a_una_pelicula
    [Tags]      CriticalRoute       Sprint9     HappyPath
    Input deep linking data     ${channel_code}     ${movie1}       movie
    Verify is playback started  25  2

DeepLinking_input_Acceder_a_una_pelicula_no_finalizada
    [Tags]      Intregracion_LastSeen
    Input deep linking data     ${channel_code}     572460      movie
    Verify is playback started  25  2
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    ${current_time}=        Informacion player      Position
    Send Key    Back
    Open channel
    Input deep linking data   ${channel_code}    572460      movie
    Verify is playback started  25  2
    ${current_new_time}=    Informacion player      Position
    ${result}=      Comparar tiempo de reproduccion     ${current_time}     ${current_new_time}
    Should Be True      ${result}