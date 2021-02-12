*** Settings ***
Documentation   Suite Landing
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

Test Setup       Launch channel

*** Variables ***


*** Test Cases ***
01_0001_Verify_channel_is_launched
    Side load   ${sideload}   ${channel_user}   ${channel_pass}

    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}

#Landing's title is available


Landing's title show correct text
    ${text}=   Get attr   attr   name   title   text
    Assert Equal   ${text}   ¡Todo lo que te gusta en un sólo lugar!
