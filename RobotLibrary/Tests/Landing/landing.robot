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
Landing's title is available


Landing's title show correct text
    ${text}=   Get attr   attr   name   title   text
    Assert Equal   ${text}   ¡Todo lo que te gusta en un sólo lugar!
