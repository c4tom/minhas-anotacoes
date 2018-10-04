Auto-digitação e Sugestão de Digitação

**Auto-digitação**

O VisuAlg tem uma característica para a criação de pseudocódigos que
pode aumentar a rapidez da digitação e também diminuir a possibilidade
de erros: é a **auto-digitação**. Para utilizar esta característica,
basta escrever uma abreviatura da palavra-chave ou do comando a ser
diigtado e teclar *Ctrl-Espaço*. O VisuAlg completa então o comando
automaticamente, colocando o cursor no ponto adequado para se continuar
a digitação (nos exemplos abaixo, este ponto é indicado através de um
\*). Eis a lista de abreviaturas com os respectivos comandos:

! - (Ponto de exclamação) Cria um modelo de pseudocódigo.

> algoritmo "semnome"
> \*
> inicio
> fimalgoritmo

\# - Cria um cabeçalho de programa.

> // Algoritmo : \*
> // Função :
> // Autor :
> // Data :

ale, aof, aon - Inserem os comandos [aleatorio](linguagem4.htm.md#aleatorio), aleatorio off ou aleatorio on,
respectivamente.

alg - Insere a linha [algoritmo](linguagem.htm.md#algoritmo) e pede a digitação do seu nome.

> algoritmo "\*"

arq - Insere o comando [arquivo](linguagem4.htm.md#arquivo) e pede a digitação do seu nome.

> arquivo "\*"

cof, con - Inserem os comandos [cronometro](linguagem4.htm.md#cronometro)

off ou cronometro on, respectivamente.

dcc - Insere uma [declaração](linguagem.htm.md#declare) de [variáveis caracteres](linguagem.htm.md#tipos).

> var  \* : caractere

dcl - Insere uma [declaração](linguagem.htm.md#var) de [variáveis lógicas](linguagem.htm.md#tipos).

> var  \* : logico

dcr - Insere uma [declaração](linguagem.htm.md#var) de [variáveis reais](linguagem.htm.md#tipos).

> var \* : real

deb - Insere o comando [debug](linguagem4.htm.md#debug).

eof, eon - Inserem os comandos [eco](linguagem4.htm.md#eco) off ou eco on, respectivamente.

esc - Insere o comando [escreva](linguagem2.htm.md#escreva).

escl - Insere o comando [escolha](linguagem2.htm.md#escolha) (sem a cláusula outrocaso).

> escolha \*
> caso
> fimescolha

esco - Insere o comando [escolha](linguagem2.htm.md#escolha) (com a cláusula outrocaso).

> escolha \*
> caso
> outrocaso
> fimescolha

enq - Insere o comando [enquanto](linguagem3.htm.md#enquanto).

> enquanto \* faca
> fimenquanto

fal - Insere a linha fimalgoritmo.

ini  - Insere a linha [inicio](linguagem.htm.md#algoritmo).

int - Insere o comando [interrompa](linguagem3.htm.md#interrompa).

lep - Insere o comando  [leia](linguagem2.htm.md#leia).

> leia (\*)

par - Insere o comando [para](linguagem3.htm.md#para).

> para \* de 1 ate faca
> fimpara

parp - Insere o comando [para](linguagem3.htm.md#para) com passo.

> para \* de ate passo faca
> fimpara

rep - Insere o comando [repita](linguagem3.htm.md#repita).

> repita
> \*
> ate

repf  - Insere o comando [repita](linguagem3.htm.md#repita) com fimrepita.

> repita
> \*
> fimrepita

see - Insere o comando [se](linguagem2.htm.md#se) sem a alternativa senao.

> se \* entao
> fimse

ses - Insere o comando [se](linguagem2.htm.md#se) completo.

> se \* entao
> senao
> fimse

tim - Insere os comandos [timer](linguagem4.htm.md#timer) on e timer off.

> timer on
> \*
> timer off

tof, ton - Inserem os comandos [timer](linguagem4.htm.md#timer) on ou timer
off, respectivamente.

**Sugestão de Digitação**

A sugestão de digitação é disponibilizada através das teclas *Ctrl-J*. Basta começar a digitação de uma palavra e teclar *Ctrl-J* para que o VisuAlg mostre uma lista com sugestões de palavras-chave que completam o que foi digitado. Para escolher, é necessário dar um duplo-clique sobre a opção desejada, ou então selecioná-la com as setas e teclar *Enter*. Se o usuário continua escrevendo depois que o VisuAlg apresentou a lista de sugestões, o programa continuará procurando palavras que ainda complementem o que foi digitado. Ao se teclar *Esc* ou clicar "fora da lista", ela desaparece.

[Objetivos](objetivos.htm.md)
[Tela principal](telaprin.htm.md)
[Menu](menu.htm.md)
[A linguagem do VisuAlg](linguagem.htm.md)
[Referências da linguagem do VisuAlg](refer.htm.md)
[Mais recursos](autocomp.htm.md)