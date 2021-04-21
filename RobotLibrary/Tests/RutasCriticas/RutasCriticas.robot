*** Settings ***
Documentation    Suite Ruta Critica
Variables       ./../../Library/variables.py
Library         ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library         Collections
Resource        ./../Utilities/keywords.robot
Resource        ./../Utilities/variables.robot

Suite Setup       Launch the channel   ${channel_code}
Test Teardown     Run if fails

*** Test Cases ***
Reproducir una pelicula desde el login seleccionando el contenido del carrusel
    [Tags]      CriticalRoute
    Access Login
    Login
    Sleep   4
    #Ubicar y seleccionar película
    Seleccionar movie
    Sleep    2
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el login seleccionando el contenido del carrusel
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    5
    Seleccionar serie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una pelicula desde el registro seleccionando el contenido del carrusel
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep   8
    #Ubicar y seleccionar película
    Seleccionar movie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el registro seleccionando el contenido del carrusel
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep   8
    Seleccionar serie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una pelicula desde el registro seleccionando el contenido del buscador
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Access the search
    Search Movie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el registro seleccionando el contenido del buscador
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Access the search
    Search Serie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2

Reproducir una pelicula desde el login seleccionando el contenido desde el buscador
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Access the search
    Search movie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2

Reproducir una serie desde el login seleccionando el contenido desde el buscador
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Access the search
    Search serie
    Sleep    3
    #Seleccionar Play
    Send key    Select
    Verify is playback started  25  2


Reproducir una pelicula desde el registro seleccionando el contenido del catalogo
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Acceder Catalogo
    Sleep    3
    Seleccionar Movie Catalogo
    Sleep    3
    Send key    Select
    Verify is playback started  25  2

Reproducir una serie desde el registro seleccionando el contenido del catalogo
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Acceder Catalogo
    Sleep    3
    Seleccionar Serie Catalogo
    Sleep    3
    Send key    Select
    Verify is playback started  25  2

Reproducir una pelicula desde el login seleccionando el contenido del catalogo
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Acceder Catalogo
    Sleep    3
    Seleccionar Movie Catalogo
    Sleep    3
    Send key    Select
    Verify is playback started  25  2

Reproducir una serie desde el login seleccionando el contenido del catalogo
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Acceder Catalogo
    Sleep    4
    Seleccionar Serie Catalogo
    Sleep    3
    Send key    Select
    Verify is playback started  25  2

Reproducir una serie desde el login seleccionando el contenido desde un carrusel y seleccionando un capitulo desde la VCard Temporada
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Seleccionar serie
    sleep    2
    #Seleccionar botón temporadas
    Send key    down
    Send key    select
    Sleep     2
    #Seleccionar capitulo desde Temporada
    Send key    Select
    Sleep      2
    #Reproducir contenido
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el login seleccionando el contenido en el search y seleccionando un capitulo desde la VCard Temporada
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Login
    Login
    Sleep    4
    Access the search
    Search Serie
    Sleep    2
    #Seleccionar botón temporadas
    Send key    down
    Send key    select
    Sleep    2
    #Seleccionar capitulo desde Temporada
    Send key    Select
    Sleep    2
    #Reproducir contenido
    Send key    Select
    Verify is playback started  25  2

Reproducir una serie desde el registro seleccionando el contenido desde un carrusel y seleccionando un capitulo desde la VCard Temporada
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Seleccionar serie
    Sleep    2
    #Seleccionar botón temporadas
    Send key    down
    Send key    select
    Sleep    2
    #Seleccionar capitulo desde Temporada
    Send key    Select
    Sleep    2
    #Reproducir contenido
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el registro seleccionando el contenido en el search y seleccionando un capitulo desde la VCard Temporada
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Search Serie
    Sleep    2
    #Seleccionar botón temporadas
    Send key    down
    Send key    select
    Sleep    2
    #Seleccionar capitulo desde Temporada
    Send key    Select
    Sleep    2
    #Reproducir contenido
    Send key    Select
    Verify is playback started  25  2


Reproducir una serie desde el registro seleccionando el contenido desde el catalogo y seleccionando un capitulo desde la VCard Temporada
    [Tags]      CriticalRoute
    [Setup]     Reabrir y logout
    Access Registration
    Register
    Sleep    8
    Acceder Catalogo
    Sleep    3
    Seleccionar Serie Catalogo
    #Seleccionar botón temporadas
    Sleep    2
    Send key    down
    Send key    select
    Sleep    2
    #Seleccionar capitulo desde Temporada
    Send key    Select
    Sleep    2
    #Reproducir contenido
    Send key    Select
    Verify is playback started  25  2




*** Keywords ***
RC Teardown
    Run if fails
    Reabrir y logout