As Funções do Visualg Versão 2.0

Toda linguagem de programação já vem com um grupo de funções que
facilitam a vida do programador. Estas funções realizam os cálculos
aritméticos, trigonométricos e de manipulação e conversão de dados mais
comuns; assim, o programador não tem que reinventar a roda a cada
programa que faz. A este grupo de funções dá-se às vezes o nome de
biblioteca.

Como usar uma função? Em termos simples, uma função pode ser usada em
qualquer lugar onde uma variável também pode, a não ser, naturalmente,
no "lado esquerdo da seta" em um comando de atribuição - uma função
produz (diz-se no linguajar dos programadores *retorna*) um valor, e não
o recebe.

Funções numéricas, algébricas e trigonométricas

**Abs( expressão)** - Retorna o valor absoluto de uma expressão do tipo inteiro ou real. Equivale a **| expressão |** na álgebra.
**ArcCos( expressão)** - Retorna o ângulo (em radianos) cujo co-seno é representado por expressão.
**ArcSen( expressão)** - Retorna o ângulo (em radianos) cujo seno é representado por expressão.
**ArcTan( expressão)** - Retorna o ângulo (em radianos) cuja tangente é representada por expressão.
**Cos( expressão)** - Retorna o co-seno do ângulo (em radianos) representado por expressão.
**CoTan( expressão)** - Retorna a co-tangente do ângulo (em radianos) representado por expressão.
**Exp( base, expoente)** - Retorna o valor de base elevado a expoente, sendo ambos expressões do tipo real.
**GraupRad( expressão)** - Retorna o valor em radianos correspondente ao valor em graus representado por expressão.
**Int( expressão)** - Retorna a parte inteira do valor representado por expressão.
**Log( expressão)** - Retorna o logaritmo na base 10 do valor representado por expressão.
**LogN( expressão)** - Retorna o logaritmo neperiano (base e) do valor representado por expressão.
**Pi** - Retorna o valor 3.141592.
**Quad( expressão)** - Retorna quadrado do valor representado por expressão.
**RadpGrau( expressão)** - Retorna o valor em graus correspondente ao valor em radianos representado por expressão.
**RaizQ( expressão)** - Retorna a raiz quadrada do valor representado por expressão.
**Rand** - Retorna um número real gerado aleatoriamente, maior ou igual a zero e menor que um.
**RandI( limite)** - Retorna um número inteiro gerado aleatoriamente, maior ou igual a zero e menor que limite.
**Sen( expressão)** - Retorna o seno do ângulo (em radianos) representado por expressão.
**Tan( expressão)** - Retorna a tangente do ângulo (em radianos) representado por expressão.

Os valores que estão entre parênteses, representados pelas palavras como *expressão*, *base* e *expoente*, são os parâmetros, ou como dizem alguns autores, os argumentos que passamos para a função para que realize seus cálculos e retorne um outro, que usaremos no programa. Algumas funções, como Pi e Rand, não precisam de parâmetros, mas a maioria tem um ou mais. O valor dos parâmetros naturalmente altera o valor retornado pela função.

A seguir temos alguns exemplos que ilustram o uso destas funções.

> algoritmo "exemplo\_funcoes"
> var a, b, c : real
> inicio
> a &lt;- 2
> b &lt;- 9
> escreval( b - a ) // será escrito 7 na tela
> escreval( abs( a - b ) ) // também será escrito 7 na tela
> c &lt;- raizq( b ) // c recebe 3, a raiz quadrada de b, que é 9
> // A fórmula da área do círculo é pi (3.1416) vezes raio ao quadrado...
> escreval("A área do circulo com raio " , c , " é " , pi \* quad(c) )
> // Um pouco de trigonometria...
> escreval("Um ângulo de 90 graus tem " , grauprad(90) , " radianos" )
> escreval( exp(a,b) ) // escreve 2 elevado à 9ª, que é 512
> // escreve 1, que é a parte inteira de 1.8, resultado de 9/(3+2)
> escreval( int( b / ( a + c ) ) )
> fimalgoritmo

Funções para manipulação de cadeias de caracteres (strings)

**Asc (s : caracter)** : Retorna um inteiro com o código ASCII do primeiro caracter da expressão.
**Carac (c : inteiro)** : Retorna o caracter cujo código ASCII corresponde à expressão.
**Caracpnum (c : caracter)** : Retorna o inteiro ou real representado pela expressão. Corresponde a StrToTin() ou StrToFloat() do Delphi, Val() do Basic ou Clipper, etc.
**Compr (c : caracter)** : Retorna um inteiro contendo o comprimento (quantidade de caracteres) da expressão.
**Copia (c : caracter ; p, n : inteiro)** : Retorna um valor do tipo caracter contendo uma cópia parcial da expressão, a partir do caracter p, contendo n caracteres. Os caracteres são numerados da esquerda para a direita, começando de 1. Corresponde a Copy() do Delphi, Mid\$() do Basic ou Substr() do Clipper.
**Maiusc (c : caracter)** : Retorna um valor caracter contendo a expressão em maiúsculas.
**Minusc (c : caracter)** : Retorna um valor caracter contendo a expressão em minúsculas.
**Numpcarac (n : inteiro ou real)** : Retorna um valor caracter contendo a representação de n como uma cadeia de caracteres. Corresponde a IntToStr() ou FloatToStr() do Delphi, Str() do Basic ou Clipper.
**Pos (subc, c : caracter)** : Retorna um inteiro que indica a posição em que a cadeia subc se encontra em c, ou zero se subc não estiver contida em c. Corresponde funcionalmente a Pos() do Delphi, Instr() do Basic ou At() do Clipper, embora a ordem dos parâmetros possa ser diferente em algumas destas linguagens.

A seguir temos alguns exemplos que ilustram o uso destas funções.

> algoritmo "exemplo\_funcoes2"
> var
> a, b, c : caracter
> inicio
>
> a &lt;- "2"
> b &lt;- "9"
> escreval( b + a ) // será escrito "92" na tela
> escreval( caracpnum(b) + caracpnum(a) ) // será escrito 11 na tela
> escreval( numpcarac(3+3) + a ) // será escrito "62" na tela
> c &lt;- "Brasil"
> escreval(maiusc(c)) // será escrito "BRASIL" na tela
> escreval(compr(c)) // será escrito 6 na tela
> b &lt;- "O melhor do Brasil"
> escreval(pos(c,b)) // será escrito 13 na tela
> escreval(asc(c)) // será escrito 66 na tela - código ASCII de "B"
> a &lt;- carac(65) + carac(66) + carac(67)
> escreval(a) // será escrito "ABC" na tela
> fimalgoritmo
