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
    Launch the channel   ${channel_code}    572460      movie
    Verify is playback started  25  2

DeepLinking_Acceder_a_una_pelicula_no_finalizada
    [Tags]      Incomplete      a
    Launch the channel   ${channel_code}    572460      movie
    Verify is playback started  25  2
    Send Key    Fwd
    Send Key    Fwd
    Sleep       10
    Send Key    Play
    Sleep       10
    &{current_time}=        Get player info
    Send Key    Back
    Send Key    Home
    Launch the channel   ${channel_code}    572460      movie
    Verify is playback started  25  2
    &{current_new_time}=    Get player info
    Should Be Equal As Strings      ${current_time}     ${current_new_time}
