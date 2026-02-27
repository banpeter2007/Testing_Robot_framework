*** Settings ***
Library    Selenium2Library

*** Keywords ***
Login with valid user
    Open Browser    https://www.saucedemo.com/    firefox
    Input Text    locator=id=user-name    text=standard_user
    Input Password    id=password    secret_sauce
    Click Button    //*[@id="login-button"]