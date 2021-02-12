*** Settings ***
Documentation    Test Execution Example
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

*** Test Cases ***
First test executed
    Side load   ${sideload}   ${channel_user}   ${channel_pass}

    ${element}=   Element identifier   attr   name   btnLogin
    Verify is screen loaded   ${element}
