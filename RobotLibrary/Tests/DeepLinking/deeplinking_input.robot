*** Settings ***
Documentation  Deep Linking
Variables  ./../Library/variables.py 
Library  ./../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library  Collections

Suite Setup     Launch channel and login
Test Setup      Open channel
Test Teardown   Run if fails
Suite Teardown  Reabrir y logout

*** Variables ***
${channel_code}  dev
${content_id}=  12
${mediaType}=  movie

*** Test Cases ***
Verify is playback started
    Input deep linking data  ${channel_code}   ${content_id}  ${mediaType}
    Verify is playback started  25  2