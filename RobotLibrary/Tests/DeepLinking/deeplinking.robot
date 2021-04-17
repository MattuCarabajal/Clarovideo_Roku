*** Settings ***
Documentation   Suite Deeplinking
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py     ${ip_address}   ${timeout}  ${pressDelay}   ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
#Suite Setup     Launch channel and login
#Test Teardown   Run if fails
#Suite Teardown  Reabrir y logout

*** Test Cases ***
08_0001_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_visualizada_previamente_usando_launch_con_usuario_logueado
    [Tags]      CriticalRoute       Sprint9     HappyPath
    # Enviar comando deeplinking con launch
    [Setup]     Send key    Home
    Launch the channel      ${channel_code}     ${movie1}       movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player      Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0002_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_finalizada_usando_launch_con_usuario_logueado
    [Tags]      Intregracion_LastSeen
    [Setup]     Send key    Home
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

08_0003_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_finalizada_usando_launch_con_usuario_logueado
    [Tags]       a      INCOMPLETE
    [Setup]     Send key    Home
    Launch the channel      ${channel_code}     572460      movie
    Verify is playback started  25  2
    ${Duracion}=    Informacion player      Duration
    Adelantar hasta el final       ${Duracion}
    ${element}=     Element identifier by text   text   Menú
    Verify is screen loaded     ${element}
    Launch the channel      ${channel_code}     572460      movie
    Verify is playback started  25  2
    ${current_time}=        Informacion player      Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0004_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_no_visualizada_previamente_usando_launch_con_usuario_logueado
    [Tags]      CriticalRoute       Sprint9     HappyPath
    [Setup]     Send key    Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel      ${channel_code}     ${episodeInicial1}      series
    # Esperar 10 segundos hardcodeados. El Wait Until no funciona acá, ya que no espera a que termine toda la función
    #   antes de seguir con el siguiente paso
    Sleep   10
    # Obtener campo text del elemento del título
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}   text
    # Verificar que el texto traído es el mismo que el que debe aparecer
    Assert Equal    ${text}     ${nombreEpisodeInicial1}
    ${current_time}=        Informacion player      Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}


    08_0011_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_visualizada_previamente_usando_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen       Probar      INCOMPLETE
    [Setup]     Reabrir y logout
    Launch the channel      ${channel_code}     572460      movie
    Login
    Verify is playback started  25  2

    08_0012_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_finalizada_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen       Probar1
    [Setup]     Reabrir y logout
    Launch the channel      ${channel_code}     572460      movie
    Login
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

#08_0013_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_finalizada_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen       Probar1
    [Setup]     Reabrir y logout
    Launch the channel      ${channel_code}     572460      episode
    Login
    Verify is playback started  25  2

08_0014_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_no_visualizada_previamente_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen       Probar1
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel      ${channel_code}     ${episodeInicial1}      series
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    # Esperar 10 segundos hardcodeados. El Wait Until no funciona acá, ya que no espera a que termine toda la función
    # antes de seguir con el siguiente paso
    Sleep   10
    # Obtener campo text del elemento del título
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}   text
    # Verificar que el texto traído es el mismo que el que debe aparecer
    Assert Equal    ${text}     ${nombreEpisodeInicial1}