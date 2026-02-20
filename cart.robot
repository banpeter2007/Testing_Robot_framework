#1. Shopping cart functionality
 #   Add multiple products
  #  Remove products from the shopping cart
   # Check the contents of the shopping cart

*** Settings ***
Library           Selenium2Library

*** Test Cases ***
Check contents of cart
    Success Login
    Add multiple products
    Check the number of elements    3
    Remove products
    Check the number of elements    1
    Check cart
    Sleep    3s
    Close Browser

*** Keywords ***
Success Login
    Open Browser    https://www.saucedemo.com/    firefox
    Input Text    locator=id=user-name    text=standard_user
    Input Password    id=password    secret_sauce
    Click Button    //*[@id="login-button"]

Add multiple products
    Click Button    //*[@id="add-to-cart-sauce-labs-backpack"]
    Click Button    //*[@id="add-to-cart-sauce-labs-bike-light"]
    Click Button    //*[@id="add-to-cart-sauce-labs-bolt-t-shirt"]
    Page Should Contain Element    //*[@id="shopping_cart_container"]/a
    #Click Element    //*[@id="shopping_cart_container"]/a
    Element Should Contain    class:shopping_cart_badge    3
    Click Element    class:shopping_cart_link

Check the number of elements
    [Arguments]    ${expected_number}
    ${count_items}=    Get Element Count    class:cart_item
    Should Be Equal As Numbers    ${count_items}    ${expected_number}

Remove products
    Click Button    //*[@id="remove-sauce-labs-backpack"]
    Click Button    //*[@id="remove-sauce-labs-bike-light"]

Check cart
    Page Should Contain Element    //*[@id="shopping_cart_container"]/a
    Page Should Contain Element    //*[@id="checkout"]