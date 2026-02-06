*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Open Saucedemo firefox
    Open Browser    https://www.saucedemo.com/    firefox
    Sleep    2s
    Close Browser

Open Saucedemo chrome
    Open Browser    https://www.saucedemo.com/    chrome
    Sleep    2s
    Close Browser