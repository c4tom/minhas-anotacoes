# A Linguagem de Programação do VisuAlg

_Subprograma_ é um programa que auxilia o programa principal através da realização de uma determinada subtarefa. Também costuma receber os nomes de *sub-rotina*, *procedimento, método* ou *módulo*. Os subprogramas são chamados dentro do corpo do programa principal como se fossem *comandos*. Após seu término, a execução continua a partir do ponto onde foi chamado. É importante compreender que a chamada de um subprograma simplesmente gera um **desvio provisório no fluxo de execução**.

Há um caso particular de subprograma que recebe o nome de *função*. Uma *função*, além de executar uma determinada tarefa, retorna um valor para quem a chamou, que é o resultado da sua execução. Por este motivo, a chamada de uma função aparece no corpo do programa principal como uma *expressão*, e não como um comando.

Cada subprograma, além de ter acesso às variáveis do programa que o chamou (são as variáveis *globais*), pode ter suas próprias variáveis (são as variáveis *locais*), que existem apenas durante sua chamada.

Ao se chamar um subprograma, também é possível passar-lhe determinadas informações que recebem o nome de *parâmetros* (são valores que, na linha de chamada, ficam entre os parênteses e que estão separados por vírgulas). A quantidade dos parâmetros, sua seqüência e respectivos tipos não podem mudar: devem estar de acordo com o que foi especificado na sua correspondente declaração.

Para se criar subprogramas, é preciso descrevê-los após a declaração das variáveis e antes do corpo do programa principal. O VisuAlg possibilita declaração e chamada de subprogramas nos moldes da linguagem Pascal, ou seja, procedimentos e funções com passagem de parâmetros por valor ou referência. Isso será explicado a seguir.

**[]{#proced}Procedimentos**

Em VisuAlg, procedimento é um subprograma que não retorna nenhum valor (corresponde ao *procedure* do Pascal). Sua declaração, que deve estar entre o final da declaração de variáveis e a linha inicio do programa principal, segue a sintaxe abaixo:

> procedimento *<nome-de-procedimento>*
> [(*<seqüência-de-declarações-de-parâmetros>*)]
> // Seção de Declarações Internas
> inicio
> // Seção de Comandos
> fimprocedimento

O *<nome-de-procedimento>* obedece as mesmas regras de nomenclatura das variáveis. Por outro lado, a *<seqüência-de-declarações-de-parâmetros>* é uma seqüência de

> [var] *<seqüência-de-parâmetros>*: *<tipo-de-dado>*

separadas por ponto e vírgula. A presença (opcional) da palavra-chave var indica passagem de parâmetros por referência; caso contrário, a passagem será por valor. 

Por sua vez, *<seqüência-de-parâmetros>* é uma seqüência de nomes de parâmetros (também obedecem a mesma regra de nomenclatura de variáveis) separados por vírgulas.

De modo análogo ao programa principal, a seção de declaração internas começa com a palavra-chave var, e continua com a seguinte sintaxe:

> *<lista-de-variáveis>* : *<tipo-de-dado>*

Nos próximos exemplos, através de um subprograma *soma* será calculada a soma entre os valores *4* e *–9* (ou seja, será obtido o resultado *13*) que o programa principal imprimirá em seguida. No primeiro caso, um **procedimento sem parâmetros** utiliza uma variável local ][aux][ para armazenar provisoriamente o resultado deste cálculo (evidentemente, esta variável é desnecessária, mas está aí apenas para ilustrar o exemplo), antes de atribuí-lo à variável global *res:*

> procedimento soma
> var aux: inteiro
> inicio
> // n, m e res são variáveis globais
> aux <- n + m
> res <- aux
> fimprocedimento

No programa principal deve haver os seguintes comandos:
> n <- 4
> m <- -9
> soma
> escreva(res)

A mesma tarefa poderia ser executada através de um **procedimento com parâmetros**, como descrito abaixo:

> procedimento soma (x,y: inteiro)
> inicio
> // res é variável global
> res <- x + y
> fimprocedimento

No programa principal deve haver os seguintes comandos:
> n <- 4
> m <- -9
> soma(n,m)
> escreva(res)

A passagem de parâmetros do exemplo acima chama-se **passagem por valor**. Neste caso, o subprograma simplesmente recebe um valor que utiliza durante sua execução. Durante essa execução, os parâmetros passados por valor são análogos às suas variáveis locais, mas com uma única diferença: receberam um valor inicial no momento em que o subprograma foi chamado.

**[]{#funcao}Funções**

Em VisuAlg, função é um subprograma que retorna um valor (corresponde ao *function* do Pascal). De modo análogo aos procedimentos, sua declaração deve estar entre o final da declaração de variáveis e a linha inicio do programa principal, e segue a sintaxe abaixo:

> funcao *<nome-de-função>* [(*<seqüência-de-declarações-de-parâmetros>*)]: *<tipo-de-dado>*
> // Seção de Declarações Internas
> inicio
> // Seção de Comandos
> fimfuncao

O *<nome-de-função>* obedece as mesmas regras de nomenclatura das variáveis. Por outro lado, a  *<seqüência-de-declarações-de-parâmetros>* é uma seqüência de
> [var] *<seqüência-de-parâmetros>*: *<tipo-de-dado>*

separadas por ponto e vírgula. A presença (opcional) da palavra-chave var indica passagem de parâmetros por referência; caso contrário, a passagem será por valor. 

Por sua vez, *<seqüência-de-parâmetros>* é uma seqüência de nomes de parâmetros (também obedecem a mesma regra de nomenclatura de variáveis) separados por vírgulas.

O valor retornado pela função será do tipo especificado na sua declaração (logo após os dois pontos). Em alguma parte da função (de modo geral, no seu final), este valor deve ser retornado através do comando []{#retorne}retorne.

De modo análogo ao programa principal, a seção de declaração internas começa com a palavra-chave var, e continua com a seguinte sintaxe:

> *<lista-de-variáveis>* : *<tipo-de-dado>*

Voltando ao exemplo anterior, no qual calculamos e imprimimos a soma entre os valores *4* e *–9,* vamos mostrar como isso poderia ser feito através de uma **função sem parâmetros*. Ela também utiliza uma variável local *aux* para armazenar provisoriamente o resultado deste cálculo, antes de atribuí-lo à variável global *res*:

> funcao soma: inteiro
> var aux: inteiro
> inicio
> // n, m e res são variáveis globais 
> aux <- n + m
> retorne aux
> fimfuncao

No programa principal deve haver os seguintes comandos:
> n <- 4
> m <- -9
> res <- soma
> escreva(res)

Se realizássemos essa mesma tarefa com uma **função com parâmetros passados por valor**, poderia ser do seguinte modo:

> funcao soma (x,y: inteiro): inteiro
> inicio
> retorne x + y
> fimfuncao

No programa principal deve haver os seguintes comandos:
> n <- 4
> m <- -9
> res <- soma(n,m)
> escreva(res)

**Passagem de Parâmetros por Referência**

Há ainda uma outra forma de passagem de parâmetros para subprogramas: é a passagem por referência. Neste caso, o subprograma não recebe apenas um valor, mas sim o **endereço** de uma variável global. Portanto, qualquer modificação que for realizada no conteúdo deste parâmetro afetará também a variável global que está associada a ele. Durante a execução do subprograma, os parâmetros passados por referência são análogos às variáveis globais. No VisuAlg, de forma análoga a Pascal, essa passagem é feita através da palavra *var* na declaração do parâmetro.

Voltando ao exemplo da soma, o procedimento abaixo realiza a mesma tarefa utilizando passagem de parâmetros por referência:

> procedimento soma (x,y: inteiro; var result: inteiro)
> inicio
> result <- x + y
> fimprocedimento

No programa principal deve haver os seguintes comandos:
> n <- 4
> m <- -9
> soma(n,m,res)
> escreva(res)]

**Recursão e Aninhamento**

A atual versão do VisuAlg permite recursão, isto é, a possibilidade de que um subprograma possa chamar a si mesmo. A função do exemplo abaixo calcula recursivamente o fatorial do número inteiro que recebe como parâmetro:

> funcao fatorial (v: inteiro): inteiro
> inicio
> se v <= 2 entao
> retorne v
> senao
> retorne v \* fatorial(v-1)
> fimse
> fimfuncao

Em Pascal, é permitido o aninhamento de subprogramas, isto é, cada subprograma também pode ter seus próprios subprogramas. No entanto, esta característica dificulta a elaboração dos compiladores e, na prática, não é muito importante. Por este motivo, ela não é permitida na maioria das linguagens de programação (como C, por exemplo), e o VisuAlg não a implementa.

[Anterior](linguagem3.htm.md) [Próxima](linguagem5.htm.md)

[Objetivos](objetivos.htm.md)
[Tela principal](telaprin.htm.md)
[Menu](menu.htm.md)
[A linguagem do VisuAlg](linguagem.htm.md)
[Referências da linguagem do VisuAlg](refer.htm.md)
[Mais recursos](autocomp.htm.md)