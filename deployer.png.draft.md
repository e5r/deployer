NOTAS SOBRE O RASCUNHO
======================

* O __Service Hub__ é basicamente um serviço de `estado`
* O `estado` é um grande registro de objetos que são criados e transitam entre `estados possíveis`
* Existem tipos de `estados`, esses tem seus `estados possíveis` cadastrados previamente
  - Basicamente há uma máquina de estados onde diz, quais todos os `estados possíveis´
  - e, quando em determinado estado, quais outros `estados são possíveis`
  - além é claro de informar o estado inicial, e os estados finais
  - Com isso sabemos como criar e quando um estado está terminado
* Uma notificação basicamente cria um estado ou modifica esse estado
  - Nessa criação/modificação são informados `metadados`
  - Os metadados são utilizados para maiores informações
  
## Detalhes

Com o serviço de estado temos um grande banco de dados onde podemos manter qualquer
coisa.

Exemplo:

* Um `hook` cria um objeto de estado informando que algo precisa ser `buildado` (construído)
* Um `Build agent` pode procurar por objetos a serem `buildados` que não estejam finalizados
  - E se conseguir `buildar` com sucesso, modifica seu estado para algo como `success`
  - Já se não conseguir `buildar` modifica seu estado para algo como `error`
  - Esse `build agent` quando consegue `buildar` com sucesso já incluiu os artefatos
    em uma imagem `Docker` e gravou no `Docker hub` interno, e adicionou o ID dessa imagem
    como `metadado` ao mudar o estado
  - Também pode criar outro objeto de estado informando que algo precisa ser `deployado` (implantado)
* Um `Deployer agent` pode procurar por objetos que precisam ser `deployados`
  - Ele busca a imagem docker nos metadados
  - Sobe os containners necessários
  - Vincula as portas no `NGINX`
  - Conseguindo com sucesso ou não, muda o estado do objeto com `success` ou `error`
  - Quando com `success`, informa as `URL's` como metadado
  - Cria outro objeto de estado informando que algo precisa ser `testado` por um humano
* Um humano acessa seu `Dashboard` e ver tudo que está aguardando ser testado
  - Os links são montados de acordo com os `metadados` dos objetos de estado
  - Ele acessa os links
  - Executa sua rotina de testes
  - E informa no `Dashboard` se tudo ocorreu bem ou não
  - A inteligência do `Dashboard` muda os estados dos objetos informados
  - Vincula mais metadados
  - Também ajusta `Issues`, `Marcos´, e etc
  - Também cria outros objetos de estado informando que algo já está pronto para
    ir a produção. O que inicia novos fluxos de implantação, liberação de versão e etc.
