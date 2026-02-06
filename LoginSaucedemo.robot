*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Open Saucedemo firefox
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=standard_user
    Input Password    id=password    secret_sauce
    # Click Button    id=login-button
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="shopping_cart_container"]/a
    Sleep    3s
    Close Browser

Login with standard_user wrong password
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=standard_user
    Input Password    id=password    secret_saucee
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="login_button_container"]/div/form/div[3]/h3
    Page Should Contain    Epic sadface: Username and password do not match any user in this service
    Sleep    3s
    Close Browser

Login with wrong username and valid password
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=standard_userr
    Input Password    id=password    secret_sauce
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="login_button_container"]/div/form/div[3]/h3
    Page Should Contain    Epic sadface: Username and password do not match any user in this service
    Sleep    3s
    Close Browser

Login without username
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=
    Input Password    id=password    secret_sauce
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="login_button_container"]/div/form/div[3]/h3
    Page Should Contain   Epic sadface: Username is required 
    Sleep    3s
    Close Browser

Login without password
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=standard_user
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="login_button_container"]/div/form/div[3]/h3
    Page Should Contain    Epic sadface: Password is required
    Sleep    3s
    Close Browser