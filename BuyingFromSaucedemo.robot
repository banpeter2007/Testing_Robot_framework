*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Buying from Suce Demo
    Open Browser    https://www.saucedemo.com/    firefox
    # Input Text    id=user-name    standard_user
    Input Text    locator=id=user-name    text=standard_user
    Input Password    id=password    secret_sauce
    # Click Button    id=login-button
    Click Button    //*[@id="login-button"]
    Page Should Contain Element    //*[@id="shopping_cart_container"]/a
    Click Button    //*[@id="add-to-cart-sauce-labs-backpack"]
    Click Element    //*[@id="shopping_cart_container"]/a
    Click Button    //*[@id="checkout"]
    Input Text    //*[@id="first-name"]    text=Peter
    Input Text    //*[@id="last-name"]    text=Ban
    Input Text    //*[@id="postal-code"]    text=6120
    Click Button    //*[@id="continue"]
    Click Button    //*[@id="finish"]
    Page Should Contain    Thank you for your order!
    Sleep    3s
    Close Browser