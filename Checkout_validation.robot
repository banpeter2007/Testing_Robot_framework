*** Settings ***
Library           Selenium2Library
Library           Collections
Resource    Login_Keyword.robot


*** Test Cases ***
    #Üres mezők ellenőrzése - név
    #Üres mezők ellenőrzése - cím
    #Üres mezők ellenőrzése - minden mező üres
    #Érvénytelen adatok kezelése - túl hosszú név        ${long_name}=    Evaluate    "A" * 100
    #Érvénytelen adatok kezelése - speciális karakterek
    #Érvénytelen adatok kezelése - csak számok a névben
    #Checkout megszakítása - Cancel gombbal    (Ellenőrzni, hogy a Cancel gomb megnyomásakor visszatér-e a kosár oldalra)
    #Érvényes adatokkal sikeres checkout folytatás

With empty name field
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=${EMPTY}
    Input Text    id=last-name    text=Ban
    Input Text    id=postal-code    text=12345
    Click Button    id=continue
    ${error_message}=    Get Text    class=error-message-container
    Should Be Equal    ${error_message}    Error: First Name is required
    Sleep    2s
    Close Browser

With empty last name field
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=Peter
    Input Text    id=last-name    text=${EMPTY}
    Input Text    id=postal-code    text=12345
    Click Button    id=continue
    ${error_message}=    Get Text    class=error-message-container
    Should Be Equal    ${error_message}    Error: Last Name is required
    Sleep    2s
    Close Browser

With empty postal code field
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=Peter
    Input Text    id=last-name    text=Ban
    Input Text    id=postal-code    text=${EMPTY}
    Click Button    id=continue
    ${error_message}=    Get Text    class=error-message-container
    Should Be Equal    ${error_message}    Error: Postal Code is required
    Sleep    2s
    Close Browser

All empty fields
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=${EMPTY}
    Input Text    id=last-name    text=${EMPTY}
    Input Text    id=postal-code    text=${EMPTY}
    Click Button    id=continue
    ${error_message}=    Get Text    class=error-message-container
    Should Be Equal    ${error_message}    Error: First Name is required
    Sleep    2s
    Close Browser

Too long name
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    ${long_name}=    Evaluate    "A" * 100
    Input Text    id=first-name    text=${long_name}
    Input Text    id=last-name    text=Ban
    Input Text    id=postal-code    text=12345
    Click Button    id=continue
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html

Special characters everywhere
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=!@#$%^&*()
    Input Text    id=last-name    text=!@#$%^&*()
    Input Text    id=postal-code    text=!@#$%^&*()
    Click Button    id=continue
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html

Only numbers in name
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=12345
    Input Text    id=last-name    text=67890
    Input Text    id=postal-code    text=12345
    Click Button    id=continue
    Location Should Be    https://www.saucedemo.com/checkout-step-one.html

Cancel checkout
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Click Button    id=cancel
    Location Should Be    https://www.saucedemo.com/cart.html

Valid checkout
    Login with valid user
    Add product to cart
    Click Element    id=checkout
    Input Text    id=first-name    text=Peter
    Input Text    id=last-name    text=Ban
    Input Text    id=postal-code    text=12345
    Click Button    id=continue
    Location Should Be    https://www.saucedemo.com/checkout-step-two.html


*** Keywords ***
Add product to cart
    Click Button    id=add-to-cart-sauce-labs-backpack
    Click Element    id=shopping_cart_container