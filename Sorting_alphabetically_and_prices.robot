*** Settings ***
Library           Selenium2Library
Library           Collections
Resource    Login_Keyword.robot


*** Test Cases ***
    #A–Z rendezés
    #Z–A rendezés
    #Ár szerint növekvő
    #Ár szerint csökkenő


Sorting Z to A
    Login with valid user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[2]
    ${product_names}=    Get all product names
    Verify Z to A    ${product_names}

Sorting A to Z
    Login with valid user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[1]
    ${product_names}=    Get all product names
    Verify A to Z    ${product_names}

Sorting price low to high
    Login with valid user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[3]
    ${product_prices}=    Get all product prices
    ${sorted_prices}=    Sort List    ${product_prices}
    Should Be Equal    ${product_prices}    ${sorted_prices}

Sorting price high to low
    Login with valid user
    Click Element    class:product_sort_container
    Click Element    //*[@id="header_container"]/div[2]/div/span/select/option[4]
    ${product_prices}=    Get all product prices
    ${reversed_prices}=    Reverse price list    ${product_prices}
    Should Not Be Equal    ${product_prices}    ${reversed_prices}
    

*** Keywords ***
Get all product names
    ${products}=    Create List
    @{product _elements}=    Get WebElements    class:inventory_item_name
    FOR    ${element}    IN    @{product _elements}
        ${product_name}=    Get Text    ${element}
        Append To List    ${products}    ${product_name}
    END
    RETURN    @{products}
    
Verify Z to A
    [Arguments]       ${product_names}
    ${lenght}=    Get Length    ${product_names}
    FOR    ${index}    IN RANGE    ${lenght}-1
        ${current}=    Get From List    ${product_names}    ${index}
        ${next}=    Get From List    ${product_names}    ${index+1}

        Should Be True    '${current}' >= '${next}'    Product is not Z to A order: current is ${current} and next is ${next} 
    END

Verify A to Z
    [Arguments]       ${product_names}
    ${lenght}=    Get Length    ${product_names}
    FOR    ${index}    IN RANGE    ${lenght}-1
        ${current}=    Get From List    ${product_names}    ${index}
        ${next}=    Get From List    ${product_names}    ${index+1}

        Should Be True    '${current}' <= '${next}'    Product is not A to Z order: current is ${current} and next is ${next} 
    END

Get all product prices
    ${prices}=    Create List
    @{price_elements}=    Get WebElements    class:inventory_item_price
    FOR    ${element}    IN    @{price_elements}
        ${price_text}=    Get Text    ${element}
        ${price}=    Convert To Number    ${price_text.replace('$', '')}
        Append To List    ${prices}    ${price}
    END
    RETURN    @{prices}

Reverse price list
    [Arguments]    ${price_list}
    ${reversed_list}=    Create List
    ${length}=    Get Length    ${price_list}
    FOR    ${index}    IN RANGE    ${length}-1    -1
        ${price}=    Get From List    ${price_list}    ${index}
        Append To List    ${reversed_list}    ${price}
    END
    RETURN    @{reversed_list}