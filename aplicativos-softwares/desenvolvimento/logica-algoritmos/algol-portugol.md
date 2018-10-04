# Tipos de Dados

O VisuAlg prevê quatro tipos de dados: inteiro, real, cadeia de caracteres e lógico (ou booleano). As palavras-chave que os definem são as seguintes (observe que elas não têm acentuação):

- inteiro: define variáveis numéricas do tipo inteiro, ou seja, sem casas decimais.
- real: define variáveis numéricas do tipo real, ou seja, com casas decimais.
- caractere: define variáveis do tipo string, ou seja, cadeia de caracteres.
- logico: define variáveis do tipo booleano, ou seja, com valor VERDADEIRO ou FALSO.
  
O VisuAlg permite também a declaração de variáveis estruturadas através da palavra-chave vetor, como será explicado a seguir.

# Comandos

## Comando SE

```algol
SE (<expressão lógica>) ENTAO
	comando1;

ou

SE (<expressão lógica>) ENTAO
	comando1;
	comando2;
FIMSE
```

## Comando SE ENTAO SENAO

```algol
SE (<expressão lógica>) ENTAO
	comando1;
	comando2;
SENAO
	comando1;
	comando2;
FIMSE
```

## Comando Caso

```algol
Escolha <Variável ou Expressão> seja
	Caso Opção1
		<comando1>;
		<comando2>;
	Caso Opção2
		<comando3>;
		<comando4>;
	Caso Opção3:
		<comando5>;
		<comando6>;
	OutroCaso
		<comando7>;
		<comando8>;
FimEscolha //fim do Escolha
```

## Comando Para



