A Linguagem de Programação do VisuAlg (1) 

**Introdução**

A linguagem que o VisuAlg interpreta é bem simples: é uma versão portuguesa dos pseudocódigos largamente utilizados nos livros de introdução à programação, conhecida como "Portugol". Tomei a liberdade de acrescentar-lhe alguns comandos novos, com o intuito de criar facilidades específicas para o ensino de técnicas de elaboração de algoritmos. Inicialmente, pensava em criar uma sintaxe muito simples e "liberal", para que o usuário se preocupasse apenas com a lógica da resolução dos problemas e não com as palavras-chave, pontos e vírgulas, etc. No entanto, cheguei depois à conclusão de que alguma formalidade seria não só necessária como útil, para criar um sentido de disciplina na elaboração do "código-fonte".

A linguagem do VisuAlg permite apenas **um comando por linha**: desse modo, não há necessidade de *tokens* separadores de estruturas, como o ponto e vírgula em Pascal. Também não existe o conceito de blocos de comandos (que correspondem ao *begin* e *end* do Pascal e ao { e } do C), nem comandos de desvio incondicional como o *goto*. Na versão atual do VisuAlg, com exceção das rotinas de entrada e saída, **não** há nenhum subprograma embutido, tal como *Inc()*, *Sqr()*, *Ord()*, *Chr()*, *Pos()*, *Copy()* ou outro.

**Importante:** para facilitar a digitação e evitar confusões, todas as palavras-chave do VisuAlg foram implementadas sem acentos, cedilha, etc. Portanto, o tipo de dados *lógico* é definido como logico, o comando *se..então..senão* é definido como se..entao..senao, e assim por diante. O VisuAlg também não distingue maiúsculas e minúsculas no reconhecimento de palavras-chave e nomes de variáveis.

**Formato Básico do Pseudocódigo e Inclusão de Comentários**

O formato básico do nosso pseudocódigo é o seguinte:

> []{#formato}algoritmo "semnome"
> // Função :
> // Autor :
> // Data : 
> // Seção de Declarações 
> inicio
> // Seção de Comandos 
> fimalgoritmo

A primeira linha é composta pela palavra-chave algoritmo seguida do seu nome delimitado por aspas duplas. Este nome será usado como título nas janelas de leitura de dados (nas futuras versões do VisuAlg, talvez utilizemos este dado de outras formas). A seção que se segue é a de declaração de variáveis, que termina com a linha que contém a palavra-chave inicio. Deste ponto em diante está a seção de comandos, que continua até a linha em que se encontre a palavra-chave fimalgoritmo. Esta última linha marca o final do pseudocódigo: todo texto existente a partir dela é ignorado pelo interpretador.

O VisuAlg permite a inclusão de comentários: qualquer texto precedido de "//" é ignorado, até se atingir o final da sua linha. Por este motivo, os comentários não se estendem por mais de uma linha: quando se deseja escrever comentários mais longos, que ocupem várias linhas, cada uma delas deverá começar por "//".

**[]{#tipos}Tipos de Dados**

O VisuAlg prevê quatro tipos de dados: **inteiro**, **real**, **cadeia
de caracteres** e **lógico** (ou *booleano*). As palavras-chave que os
definem são as seguintes (observe que elas não têm acentuação):

> - inteiro: define variáveis numéricas do tipo inteiro, ou seja, sem casas decimais.
> - real: define variáveis numéricas do tipo real, ou seja, com casas decimais.
> - caractere: define variáveis do tipo *string*, ou seja, cadeia de caracteres.
> - logico: define variáveis do tipo *booleano*, ou seja, com valor VERDADEIRO ou FALSO.

[]{#vetor}O VisuAlg permite também a declaração de variáveis estruturadas através da palavra-chave vetor, como será explicado a seguir.

**[]{#var}Nomes de Variáveis e sua Declaração**

Os nomes das variáveis devem começar por uma letra e depois conter letras, números ou *underline*, até um limite de 30 caracteres. As variáveis podem ser simples ou estruturadas (na versão atual, os vetores podem ser de uma ou duas dimensões). Não pode haver duas variáveis com o mesmo nome, com a natural exceção dos elementos de um mesmo vetor.

A seção de declaração de variáveis começa com a palavra-chave var, e continua com as seguintes sintaxes:

> *<lista-de-variáveis&gt;* : *<tipo-de-dado&gt;
> <lista-de-variáveis&gt;* : vetor
> "["*<lista-de-intervalos&gt;"*]" de *<tipo-de-dado&gt;*

Na *<lista-de-variáveis&gt;*, os nomes das variáveis estão separados por vírgulas. Na *<lista-de-intervalos&gt;*, os *<intervalo&gt;* são separados por vírgulas, e têm a seguinte sintaxe:

> *<intervalo&gt;*: *<valor-inicial&gt;* .. *<valor-final&gt;* 

Na versão atual do VisuAlg, tanto *<valor-inicial&gt;* como *<valor-final&gt;* devem ser inteiros. Além disso, exige-se evidentemente que *<valor-final&gt;* seja maior do que *<valor-inicial&gt;*.

Exemplos:

> var a: inteiro
> Valor1, Valor2: real
> vet: vetor [1..10] de real
> matriz: vetor [0..4,8..10] de inteiro
> nome_do_aluno: caractere
> sinalizador: logico

Note que não há a necessidade de ponto e vírgula após cada declaração: basta pular linha. A declaração de vetores é análoga à linguagem Pascal: a variável vet acima tem 10 elementos, com os índices de [1] a [10], enquanto matriz corresponde a 15 elementos com índices [0,8], [0,9], [0,10], [1,8], [1,9], [1,10], ... até [4,10]. O número total de variáveis suportado pelo VisuAlg é 500 (cada elemento de um vetor é contado individualmente).

**[]{#constantes}Constantes e Comando de Atribuição**

O VisuAlg tem três tipos de constantes:

> - *Numéricos*: são valores numéricos escritos na forma usual das linguagens de programação. Podem ser inteiros ou reais. Neste último caso, o separador de decimais é o ponto e não a vírgula, independente da configuração regional do computador onde o VisuAlg está sendo executado. O VisuAlg também não suporta separadores de milhares.
> - *Caracteres*: qualquer cadeia de caracteres delimitada por aspas duplas (").
> - *Lógicos*: admite os valores VERDADEIRO ou FALSO.

A atribuição de valores a variáveis é feita com o operador <-. Do seu lado esquerdo fica a variável à qual está sendo atribuído o valor, e à sua direita pode-se colocar qualquer expressão (constantes, variáveis, expressões numéricas), desde que seu resultado tenha tipo igual ao da variável.

Alguns exemplos de atribuições, usando as variáveis declaradas acima:

> a <- 3
> Valor1 <- 1.5
> Valor2 <- Valor1 + a
> vet[1] <- vet[1] + (a * 3)
> matriz[3,9] <- a/4 - 5
> nome_do_aluno <- "José da Silva"
> sinalizador <- FALSO

[Próxima](linguagem2.htm.md)
[Objetivos](objetivos.htm.md)
[Tela principal](telaprin.htm.md)
[Menu](menu.htm.md)
[A linguagem do VisuAlg](linguagem.htm.md)
[Referências da linguagem do VisuAlg](refer.htm.md)
[Mais recursos](autocomp.htm.md)
