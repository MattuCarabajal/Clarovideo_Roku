*** Settings ***
Documentation   Deep Linking Input
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

#Recordar antes de pushear descomentar Test Setup Launch channel
#Suite Setup     Launch channel and login
Test Setup      Open channel
#Test Teardown   Run if fails
#Suite Teardown  Reabrir y logout

*** Test Cases ***
08_0019_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_visualizada_previamente_usando_el_input
    [Tags]      CriticalRoute
    Input deep linking data    ${channel_code}     ${movie1}       movie
    Sleep   5
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0020_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_finalizada_usando_el_input
    [Tags]      Intregracion_LastSeen
    # Enviar comando deeplinking con input
    Input deep linking data    ${channel_code}     ${movie1}       movie
    Sleep   5
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #adelantar el contenido
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player           Position
    #Salir del reproductor
    Send Key    Back
    #Reabrir la aplicación ubicandose en la Home de la misma
    Open channel
    # Enviar comando deeplinking con input
    Input deep linking data           ${channel_code}    572460      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que la reproduccion empieza en la posicion anterior
    ${current_new_time}=    Informacion player           Position
    ${result}=      Comparar tiempo de reproduccion     ${current_time}     ${current_new_time}
    Should Be True      ${result}

08_0021_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_finalizada_usando_el_input_con_usuario_logueado
    [Tags]
    # Enviar comando deeplinking con input
    Input deep linking data          ${channel_code}    572460      movie
    # Verificar que comienza la reproducción
    Sleep   5
    Verify is playback started  25  2
    #Guardar el tiempo de reproducción completo en una variable
    ${Duracion}=    Informacion player                   Duration
    #adelantar el contenido hasta el final
    Adelantar       ${Duracion}
    ${element}=     Element identifier by text           text   Menú
    Verify is screen loaded     ${element}
    #Reabrir la aplicación ubicandose en la Home de la misma
    Open channel
    # Enviar comando deeplinking con input
    Input deep linking data           ${channel_code}    572460      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que el contenido se reprodujo desde el inicio
    ${current_time}=        Informacion player           Position
    ${result}=        Verificar inicio de contenido      ${current_time}
    Should Be True      ${result}


08_0022_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_no_visualizada_previamente_usando_el_input
    [Tags]      CriticalRoute
    # Enviar comando deeplinking del tipo launch
    Input deep linking data          ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0023_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_no_haya_sido_finalizado_usando_el_input
    [Tags]      Intregracion_LastSeen
    # Enviar comando deeplinking con input
    Input deep linking data          ${channel_code}     ${episodeInicial1}      episode
    Sleep   5
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #adelantar el contenido
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player           Position
    #Salir del reproductor
    Send Key    Back
    #Reabrir la aplicación ubicandose en la Home de la misma
    Open channel
    # Enviar comando deeplinking con input
    Input deep linking data               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que la reproduccion empieza en la posicion anterior
    ${current_new_time}=    Informacion player           Position
    ${result}=      Comparar tiempo de reproduccion     ${current_time}     ${current_new_time}
    Should Be True      ${result}

08_0024_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_haya_sido_finalizado_usando_el_input
    [Tags]      Intregracion_LastSeen
    # Enviar comando deeplinking con input
    Input deep linking data               ${channel_code}     ${episodeInicial1}      episode
    Sleep   5
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Guardar el tiempo de reproducción completo en una variable
    ${Duracion}=    Informacion player      Duration
    #Adelantar el contenido hasta el final
    Adelantar    ${Duracion}
    ${element}=     Element identifier by text            text   Menú
    Verify is screen loaded     ${element}
    #Reabrir la aplicación ubicandose en la Home de la misma
    Open channel
    # Enviar comando deeplinking con launch
    Input deep linking data               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que el contenido se reprodujo desde el inicio
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0025_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_otro_episodio_no_haya_sido_finalizado_usando_el_input
    [Tags]      Intregracion_LastSeen
    # Enviar comando deeplinking con input
    Input deep linking data               ${channel_code}     758667     episode
    Sleep   5
    # Verificar que comienza la reproducción
    Verify is playback started  28  2
    #Pausar la reproduccion
    Send key     Play
    #Salir a la Vcard
    Send key     Back
    #Verificar que el capitulo que se reprodujo es el correspindiente al contentId
    Sleep   10
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}    text
    Assert Equal    ${text}     ${nombreEpisodeInicial2}



08_0027_DEEPLINKING_Acceder_con_deep_linking_a_una_vcard_de_una_serie_usando_season_usando_el_input
    [Tags]      CriticalRoute
    # Enviar comando deeplinking del tipo launch
    Input deep linking data               ${channel_code}     ${episodeInicial2}      season
    #Verificar que cargo la VCard
    Sleep   10
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}    text
    Assert Equal    ${text}     ${nombreEpisodeInicial2}