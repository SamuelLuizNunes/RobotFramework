*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.amazon.com.br
${MENU_ELETRONICOS}    //a[contains(.,'Eletrônicos')]
${HEADER_ELETRONICO}    //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome
    Maximize Browser Window

Fechar o navegador
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICO}        

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}    

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]