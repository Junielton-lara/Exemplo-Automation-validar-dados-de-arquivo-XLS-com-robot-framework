*** Settings ***
##########################################################################
#                                 Libraries                              #
##########################################################################


Library  ./resources/libs/utilities.py

*** Test Cases ***

CA01: Validar que no arquivo XLS contem os dados corretos
    [Tags]    
    Dado que efetuo a leitura de um arquivo xls
    Quando esse aquivo é lido com sucesso
    Então o mesmo devera ter um total de registros = a "15"
    E conter dados da pessoa "MELISSA CHAMON" e a data "27/07/2022"

*** Keywords ***

Dado que efetuo a leitura de um arquivo xls
    ${files}  Get All Files With Name Start With  C:${/}Users${/}user${/}Downloads  .xls  ConsultarPessoas_
    ${content}  Get All Lines From XLS  ${files[0]}

    Set Test Variable     ${files}
    Set Test Variable    ${content}
Quando esse aquivo é lido com sucesso
    Log To Console    Dados do arquivo ${content}
    Log   Dados do arquivo ${content}

Então o mesmo devera ter um total de registros = a "${total_linhas}"
    ${size}  Evaluate  str(len($content)-1)
    Should Be Equal    ${total_linhas}  ${size}

E conter dados da pessoa "${pessoa}" e a data "${data}"
    FOR  ${f}  IN  @{files}
        ${lines}  Get All Lines From XLS  ${f}
        ${lines}  Evaluate    $lines[1::]
        ${str}  Evaluate    $lines.__str__()
        ${contains}  Evaluate  $pessoa in $str and $data in $str
    END
    Should Be True    ${contains}