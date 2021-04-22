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
    [Setup]     Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${movie1}       movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0002_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_finalizada_usando_launch_con_usuario_logueado
    [Tags]      Intregracion_LastSeen       NoreconoceKeyword
    [Setup]     Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel              ${channel_code}     ${movie1}      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar El contenido
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player          Position
    Send Key    Back
    #Salir a la Home del Roku
    Send Key    Home
    # Enviar comando deeplinking con launch
    Launch the channel              ${channel_code}     ${movie1}      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que la reproduccion empieza en la posicion anterior
    ${current_new_time}=    Informacion player           Position
    ${result}=      Comparar tiempo de reproduccion      ${current_time}     ${current_new_time}
    Should Be True      ${result}


08_0003_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_finalizada_usando_launch_con_usuario_logueado
    [Tags]      NoreconoceKeyword
    [Setup]     Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel                ${channel_code}     572460      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Guardar el tiempo de reproducción completo en una variable
    ${Duracion}=    Informacion player      Duration
    #adelantar el contenido hasta el final
    Adelantar       ${Duracion}
    ${element}=     Element identifier by text            text   Menú
    Verify is screen loaded     ${element}
    #Salir a la Home del roku
    Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel                ${channel_code}     572460      movie
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que el contenido se reprodujo desde el inicio
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0004_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_no_visualizada_previamente_usando_launch_con_usuario_logueado
    [Tags]      CriticalRoute       Sprint9     HappyPath
    [Setup]     Send key    Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0005_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_no_haya_sido_finalizado_usando_launch_con_usuario_logueado
    [Tags]      Intregracion_LastSeen       NoreconoceKeyword       q
    [Setup]     Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar El contenido
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player           Position
    Send Key    Back
    #Salir a la Home del Roku
    Send Key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que la reproduccion empieza en la posicion anterior
    ${current_new_time}=    Informacion player           Position
    ${result}=      Comparar tiempo de reproduccion       ${current_time}       ${current_new_time}
    Should Be True      ${result}

08_0006_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_haya_sido_finalizado_usando_launch_con_usuario_logueado
    [Tags]       IncompleteEncard
    [Setup]     Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  28  2
    #Guardar el tiempo de reproducción completo en una variable
    ${Duracion}=    Informacion player      Duration
    #Adelantar el contenido hasta el final
    Adelantar       ${Duracion}
    #${element}=     Element identifier by text            text   Menú
    #Verify is screen loaded     ${element}
    #Salir a la Home del roku
    Send key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que el contenido se reprodujo desde el inicio
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True      ${result}

08_0007_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_otro_episodio_no_haya_sido_finalizado_usando_launch_con_usuario_logueado
    [Tags]      CriticalRoute       Sprint9     HappyPath
    [Setup]     Send key    Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeNoInicial3}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Pausar la reproduccion
    Send key     Play
    #Salir a la Vcard
    Send key     Back
    #Verificar que el capitulo que se reprodujo es el correspindiente al contentId
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}    text
    Assert Equal    ${text}     Domingo en el parque con Fran

08_0009_DEEPLINKING_Acceder_con_deep_linking_a_una_vcard_de_una_serie_usando_season_usando_launch_con_usuario_logueado
    [Tags]      CriticalRoute       Sprint9     HappyPath
    [Setup]     Send key    Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      season
    #Verificar que cargo la VCard
    ${element}=     Element identifier by text   text   Menú
    Verify is screen loaded     ${element}

08_0010_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_visualizada_previamente_usando_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel                ${channel_code}      ${movie3}       movie
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player            Position
    ${result}=        Verificar inicio de contenido       ${current_time}
    Should Be True          ${result}

08_0011_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_no_finalizada_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen      NoreconoceKeyword
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch, se debe cambiar el ContentId cada vez que se ejecute la prueba
    Launch the channel                ${channel_code}      ${movie3}       movie
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player             Position
    Send Key    Back
    #Salida a la home de Roku
    Send Key    Home
    #Enviar comando deeplinking del tipo launch
    Launch the channel                ${channel_code}      ${movie3}       movie
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicio donde se pauso anteriormente
    ${current_new_time}=    Informacion player             Position
    ${result}=      Comparar tiempo de reproduccion        ${current_time}     ${current_new_time}
    Should Be True           ${result}

08_0012_DEEPLINKING_Acceder_con_deep_linking_a_una_pelicula_finalizada_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel                ${channel_code}      ${movie3}       movie
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar contenido hasta el final
    ${Duracion}=    Informacion player             Duration
    Adelantar                ${Duracion}
    ${element}=     Element identifier by text     text          Menú
    Verify is screen loaded                        ${element}
    #Salida a la Home de Roku
    Send key        Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel                ${channel_code}      ${movie3}       movie
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicia desde el comienzo
    ${current_time}=        Informacion player                  Position
    ${result}=              Verificar inicio de contenido       ${current_time}
    Should Be True          ${result}

08_0013_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_no_visualizada_previamente_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel                     ${channel_code}     ${episodeInicial1}      episode
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    #Verificar que comienza la reproducción
    Verify is playback started  28  2
    #Verificar que inicio desde el comienzo
    ${current_time}=        Informacion player                   Position
    ${result}=              Verificar inicio de contenido        ${current_time}
    Should Be True          ${result}

08_0014_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_no_haya_sido_finalizado_usando_el_launch_sin_estar_logueado
    [Tags]      Intregracion_LastSeen      NoreconoceKeyword
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking con launch
    Launch the channel                    ${channel_code}     ${episodeInicial1}      episode
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar El contenido
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    Send Key    Play
    #Verificar posicion de la reproduccion
    ${current_time}=        Informacion player           Position
    Send Key    Back
    #Salir a la Home del Roku
    Send Key    Home
    # Enviar comando deeplinking con launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que la reproduccion empieza en la posicion anterior
    ${current_new_time}=    Informacion player           Position
    ${result}=      Comparar tiempo de reproduccion      ${current_time}     ${current_new_time}
    Should Be True      ${result}

08_0015_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_primer_episodio_haya_sido_finalizado_usando_el_launch_sin_estar_logueado
    [Tags]      IncompleteEncard
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Adelantar contenido hasta el final
    ${Duracion}=    Informacion player             Duration
    Adelantar                        ${Duracion}
    ${element}=     Element identifier by text     text          Menú
    Verify is screen loaded                        ${element}
    #Salida a la Home de Roku
    Send key        Home
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeInicial1}      episode
    #Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Verificar que inicia desde el comienzo
    ${current_time}=        Informacion player                  Position
    ${result}=              Verificar inicio de contenido       ${current_time}
    Should Be True          ${result}

08_0016_DEEPLINKING_Acceder_con_deep_linking_a_una_serie_cuyo_otro_episodio_no_haya_sido_finalizado_usando_el_launch_sin_estar_logueado
    [Tags]
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeNoInicial3}      episode
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    # Verificar que comienza la reproducción
    Verify is playback started  25  2
    #Pausar la reproduccion
    Send key     Play
    #Salir a la Vcard
    Send key     Back
    #Verificar que el capitulo que se reprodujo es el correspindiente al contentId
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}    text
    Assert Equal    ${text}     Domingo en el parque con Fran

08_0018_DEEPLINKING_Acceder_con_deep_linking_a_una_vcard_de_una_serie_usando_season_usando_el_launch_sin_estar_logueado
    [Tags]
    [Setup]     Reabrir y logout
    # Enviar comando deeplinking del tipo launch
    Launch the channel               ${channel_code}     ${episodeNoInicial3}      season
    #Aparece el mensaje de solicitud de informacion, este se cancela y se inicia sesion
    Login
    #Verificar que cargo la VCard
    Sleep   10
    ${text}=        Get attr    attr    bounds    {0, 0, 735.667, 30}    text
    Assert Equal    ${text}     Domingo en el parque con Fran