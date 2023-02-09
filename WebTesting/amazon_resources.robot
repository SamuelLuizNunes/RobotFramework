*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}             chrome
${URL}                 https://www.amazon.com.br
${MENU_ELETRONICOS}    //a[contains(.,'Eletrônicos')]
${HEADER_ELETRONICO}   //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
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

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=//input[@name='field-keywords']    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button        

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]

# GHERKIN STEPS

Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "${TITULO}"
    Verificar se o título da página fica "${TITULO}"

E o texto "${FRASE}" deve ser exibido na página
    Verificar se aparece a frase "${FRASE}"

E a categoria "${NOME_CATEGORIA}" deve ser exibida na página
    Verificar se aparece a categoria "${NOME_CATEGORIA}"    

Quando pesquisar pelo produto "${PRODUTO}"
    Digitar o nome de produto "${PRODUTO}" nocampo de pesquisa    
    Clicar no botão de pesquisa

E um produto da linha "${PRODUTO}" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"

# Carrinho de compra

Adicionar o produto "Console Xbox Series S" no carrinho
    Click Link    locator=(//a[contains(.,'Console Xbox Series S')])[1]
    Click Button    locator=//input[contains(@name,'submit.add-to-cart')]

Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso
    Element Should Be Visible    locator=//span[contains(.,'Adicionado ao carrinho')]    

Remover o produto "Console Xbox Series S" do carrinho
    Click Link    locator=//a[contains(@data-csa-c-type,'button')]
    Click Button    locator=//input[@value='Excluir']

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=//h1[contains(.,'Seu carrinho de compras da Amazon está vazio.')]