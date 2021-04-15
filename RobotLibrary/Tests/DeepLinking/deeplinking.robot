*** Settings ***
Documentation   Deep Linking
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
Suite Setup     Launch channel and login
Test Setup      Send key    Home
Test Teardown   Run if fails
Suite Teardown  Reabrir y logout

*** Test Cases ***
DeepLinking_Acceder_a_una_pelicula
    [Tags]      CriticalRoute       Sprint9     HappyPath
    # Enviar comando deeplinking con launch
    Launch the channel      ${channel_code}     ${movie1}       movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2

DeepLinking_Acceder_a_una_serie
    [Tags]      CriticalRoute       Sprint9     HappyPath
    # Enviar comando deeplinking del tipo launch
    Launch the channel      ${channel_code}     ${episodeInicial1}      series
    # Esperar 10 segundos hardcodeados. El Wait Until no funciona acá, ya que no espera a que termine toda la función
    #   antes de seguir con el siguiente paso
    Sleep   10
    # Obtener campo text del elemento del título
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}   text
    # Verificar que el texto traído es el mismo que el que debe aparecer
    Assert Equal    ${text}     ${nombreEpisodeInicial1}

DeepLinking_Acceder_a_una_pelicula_no_finalizada
    [Tags]      Intregracion_LastSeen
    Launch the channel      ${channel_code}     572460      movie
    Verify is playback started  25  2
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    ${current_time}=        Informacion player      Position
    Send Key    Back
    Send Key    Home
    Launch the channel      ${channel_code}     572460      movie
    Verify is playback started  25  2
    ${current_new_time}=    Informacion player      Position
    ${result}=      Comparar tiempo de reproduccion     ${current_time}     ${current_new_time}
    Should Be True      ${result}