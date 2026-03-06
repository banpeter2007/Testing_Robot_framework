*** Settings ***
Library           Selenium2Library
Library           Collections
Resource    Login_Keyword.robot


*** Test Cases ***
    #Termék oldal megnyitása - név alapján
    #Termék oldal megnyitása - kép alapján
    #Termék információk ellenőrzése - név  (ugyaz-e?)
    #Termék információk ellenőrzése - ár (ugyaz-e?)
    #Termék információk ellenőrzése - leírás        (egyáltalán megjelenik-e?)
    #Termék információk ellenőrzése - kép    (egyáltalán megjelenik-e?)
    #Vissza navigáció - Back to products gomb

Open by product name
    Login with valid user
    Click Element    class:inventory_item_name
    ${product_name}=    Get Text    class:inventory_details_name
    Should Be Equal    ${product_name}    Sauce Labs Backpack
    Sleep    2s
    Close Browser

Open by product image
    Login with valid user
    Click Element    class:inventory_item_img
    ${product_name}=    Get Text    class:inventory_details_name
    Should Be Equal    ${product_name}    Sauce Labs Backpack
    Sleep    2s
    Close Browser

Same name
    Login with valid user
    Same name in details as in inventory
    Sleep    2s
    Close Browser

Same price
    Login with valid user
    Same price in details as in inventory
    Sleep    2s
    Close Browser

Is there a description
    Login with valid user
    Click Element    class:inventory_item_name
    ${description}=    Get Text    class:inventory_details_desc
    Should Not Be Empty    ${description}
    Sleep    2s
    Close Browser

Is there an image
    Login with valid user
    Click Element    class:inventory_item_name
    ${image}=    Get WebElement    class:inventory_details_img
    #keresse meg hogy a kép megjelenik-e
    Element Should Be Visible    ${image}
    Sleep    2s
    Close Browser

Is there a back to products button
    Login with valid user
    Click Element    class:inventory_item_name
    ${button}=   Get WebElement    id:back-to-products
    Element Should Be Visible    ${button}
    Click Element    id:back-to-products
    Sleep    2s
    Close Browser


*** Keywords ***
Get all product names in to a List
    ${products}=    Create List
    @{product _elements}=    Get WebElements    class:inventory_item_name
    FOR    ${element}    IN    @{product _elements}
        ${product_name}=    Get Text    ${element}
        Append To List    ${products}    ${product_name}
    END
    RETURN    @{products}

Get all product prices in to a List
    ${prices}=    Create List
    @{price _elements}=    Get WebElements    class:inventory_item_price
    FOR    ${element}    IN    @{price _elements}
        ${product_price}=    Get Text    ${element}
        Append To List    ${prices}    ${product_price}
    END
    RETURN    @{prices}

Get all product images in to a List
    ${images}=    Create List
    @{image _elements}=    Get WebElements    class:inventory_item_img
    FOR    ${element}    IN    @{image _elements}
        ${product_image}=    Get Element Attribute    ${element}    src
        Append To List    ${images}    ${product_image}
    END
    RETURN    @{images}

Same name in details as in inventory
    ${product_name}=    Get Text    class:inventory_item_name
    Click Element    class:inventory_item_name
    ${product_name_details}=    Get Text    class:inventory_details_name
    Should Be Equal    ${product_name}    ${product_name_details}

Same price in details as in inventory
    ${product_price}=    Get Text    class:inventory_item_price
    Click Element    class:inventory_item_name
    ${product_price_details}=    Get Text    class:inventory_details_price
    Should Be Equal    ${product_price}    ${product_price_details}