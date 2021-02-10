*** Settings ***
Documentation  Test for tests
Variables   ./../../Library/variables.py
Library   ./../../Library/RobotLibrary.py  ${ip_address}  ${timeout}  ${pressDelay}  ${server_path}
Library   Collections
Library   BuiltIn
Resource   ./../Utilities/keywords.robot
Resource   ./../Utilities/variables.robot

#Probando Setup
Test Setup       Launch channel

*** Variables ***


*** Test Cases ***
Get value from attribute

    ${text}=   Get attr   attr   name   title   text
    Assert Equal   ${text}   ¡Todo lo que te gusta en un sólo lugar!
