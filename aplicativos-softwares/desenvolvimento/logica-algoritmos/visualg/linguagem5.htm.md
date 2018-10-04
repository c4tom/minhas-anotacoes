# A Linguagem de Programação do VisuAlg

O VisuAlg implementa algumas extensões às linguagens "tradicionais" de programação, com o intuito principal de ajudar o seu uso como ferramenta de ensino. Elas são mostradas a seguir.

**[](linguagem5.htm.md#aleatorio){#aleatorio}Comando Aleatório**

Muitas vezes a digitação de dados para o teste de um programa torna-se uma tarefa entediante. Com o uso do comando aleatorio do VisuAlg, sempre que um comando leia for encontrado, a digitação de valores numéricos e/ou caracteres é substituída por uma geração aleatória. Este comando não afeta a leitura de variáveis lógicas: com certeza, uma coisa pouco usual em programação... 

Este comando tem as seguintes sintaxes:

- aleatorio [on] Ativa a geração de valores aleatórios que substituem a digitação de dados. A palavra-chave on é opcional. A faixa padrão de valores gerados é de 0 a 100 inclusive. Para a geração de dados do tipo caractere, não há uma faixa pré-estabelecida: os dados gerados serão sempre *strings* de 5 letras maiúsculas.
  aleatorio *<valor1>* [, *<valor2>* ]   Ativa a geração de dados numéricos aleatórios estabelecendo uma faixa de valores mínimos e máximos. Se apenas *< valor1>* for fornecido, a faixa será de 0 a *<valor1>* inclusive; caso contrário, a faixa será de *<valor1>* a *<valor2>* inclusive. Se *<valor2>* for menor que *<valor1>*, o VisuAlg os trocará para que a faixa fique correta.  **
Importante:** *<valor1>* e *<valor2>* devem ser **constantes numéricas**, e não expressões.

- aleatorio off Desativa a geração de valores aleatórios. A palavra-chave off é obrigatória.

**[](linguagem5.htm.md#arquivo){#arquivo} Comando Arquivo**

Muitas vezes é necessário repetir os testes de um programa com uma série igual de dados. Para casos como este, o VisuAlg permite o armazenamento de dados em um arquivo-texto, obtendo deles os dados ao executar os comandos leia. 

Esta característica funciona da seguinte maneira:
1) Se **não existir** o arquivo com nome especificado, o VisuAlg fará uma leitura de dados através da digitação, armazenando os dados lidos neste arquivo, na ordem em que forem fornecidos.
2) Se o arquivo **existir**, o VisuAlg obterá os dados deste arquivo até chegar ao seu fim. Daí em diante, fará as leituras de dados através da digitação.
3) Somente um comando arquivo pode ser empregado em cada pseudocódigo, e ele deverá estar na seção de declarações (dependendo do "sucesso" desta característica, em futuras versões ela poderá ser melhorada...).
4) Caso não seja fornecido um caminho, o VisuAlg irá procurar este arquivo na pasta de trabalho corrente (geralmente, é a pasta onde o programa VISUALG.EXE está). Este comando não prevê uma extensão padrão; portanto, a especificação do nome do arquivo deve ser completa, inclusive com sua extensão (por exemplo, .txt, .dat, etc.).

A sintaxe do comando é:

arquivo *<nome-de-arquivo>*

*<nome-de-arquivo>* é uma constante caractere (entre aspas duplas). Veja o exemplo a seguir:

> algoritmo "lendo do arquivo"
> arquivo "teste.txt"
> var x,y: inteiro
> inicio
> para x de 1 ate 5 faca
>    leia (y)
> fimpara
> fimalgoritmo

**[]{#timer}Comando Timer**

Embora o VisuAlg seja um interpretador de pseudocódigo, seu desempenho é muito bom: o tempo gasto para interpretar cada linha digitada é apenas uma fração de segundo. Entretanto, por motivos educacionais, pode ser conveniente exibir o fluxo de execução do pseudocódigo comando por comando, em "câmera lenta". O comando timer serve para este propósito: insere um atraso (que pode ser especificado) antes da execução de cada linha. Além disso, realça em fundo azul o comando que está sendo executado, da mesma forma que na execução passo a passo.

Sua sintaxe é a seguinte:

- timer **on** : Ativa o *timer*.
- timer *<tempo-de-atraso>* : Ativa o *timer* estabelecendo seu tempo de atraso em milissegundos. O valor padrão é 500, que equivale a meio segundo. O argumento *<tempo-de-atraso>* deve ser uma constante inteira com valor entre 0 e 10000. Valores menores que 0 são corrigidos para 0, e maiores que 10000 para 10000.
- timer **off** : Desativa o *timer.*

Ao longo do pseudocódigo, pode haver vários comandos timer. Todos eles devem estar na seção de comandos. Uma vez ativado, o atraso na execução dos comandos será mantido até se chegar ao final do pseudocódigo ou até ser encontrado um comando timer off.

**Comandos de Depuração**

Nenhum ambiente de desenvolvimento está completo se não houver a possibilidade de se inserir pontos de interrupção (*breakpoints*) no pseudocódigo para fins de depuração. VisuAlg implementa dois comandos que auxiliam a depuração ou análise de um pseudocódigo: o comando pausa e o comando debug.

**[]{#pausa}Comando Pausa**

Sua sintaxe é simplesmente:

pausa

Este comando insere uma interrupção incondicional no pseudocódigo. Quando ele é encontrado, o VisuAlg pára a execução do pseudocódigo e espera alguma ação do programador. Neste momento, é possível: analisar os valores das variáveis ou das saídas produzidas até o momento; executar o pseudocódigo passo a passo (com F8); prosseguir sua execução normalmente (com F9); ou simplesmente terminá-lo (com Ctrl-F2). Com exceção da alteração do texto do pseudocódigo, todas as funções do VisuAlg estão disponíveis.

**[]{#debug}Comando Debug**

Sua sintaxe é:

debug <*expressão-lógica*>

Se a avaliação de <*expressão-lógica*> resultar em valor VERDADEIRO, a execução do pseudocódigo será interrompida como no comando pausa. Dessa forma, é possível a inserção de um *breakpoint* condicional no pseudocódigo.

**[]{#eco}Comando Eco**

Sua sintaxe é: 

eco on | off  

Este comando ativa (eco on) ou desativa (eco off) a impressão dos dados de entrada na saída-padrão do VisuAlg, ou seja, na área à direita da parte inferior da tela. Esta característica pode ser útil quando houver uma grande quantidade de dados de entrada, e se deseja apenas analisar a saída produzida. Convém utilizá-la também quando os dados de entrada provêm de um arquivo já conhecido.

**[]{#cronometro}Comando Cronômetro**

Sua sintaxe é:

cronometro on | off  

Este comando ativa (cronometro on) ou desativa (cronometro off) o cronômetro interno do VisuAlg. Quando o comando cronometro on é encontrado, o VisuAlg imprime na saída-padrão a informação "Cronômetro iniciado.", e começa a contar o tempo em milissegundos. Quando o comando cronometro off é encontrado, o VisuAlg imprime na saída-padrão a informação "Cronômetro terminado. Tempo decorrido: xx segundo(s) e xx ms". Este comando é útil na análise de desempenho de algoritmos (ordenação, busca, etc.). 

**[]{#limpatela}Comando Limpatela**

Sua sintaxe é

limpatela

Este comando simplesmente limpa a tela DOS do Visualg (a simulação da tela do computador). Ele não afeta a "tela" que existe na parte inferior direita da janela principal do Visualg.

[Anterior](linguagem4.htm.md)

[Objetivos](objetivos.htm.md)
[Tela principal](telaprin.htm.md)
[Menu](menu.htm.md)
[A linguagem do VisuAlg](linguagem.htm.md)
[Referências da linguagem do VisuAlg](refer.htm.md)
[Mais recursos](autocomp.htm.md)
