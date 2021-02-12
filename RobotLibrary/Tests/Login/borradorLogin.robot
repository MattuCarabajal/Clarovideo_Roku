*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Probando Setup
#Test Setup       Launch the channel

*** Variables ***


*** Test Cases ***
Probando crear mail

    ${newmail}=   Create mail
