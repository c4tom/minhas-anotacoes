Menu do VisuAlg

Este menu compõe-se de 7 partes:

**Arquivo: ** Possui os comandos para se abrir, salvar e imprimir
algoritmos:

> **Novo:** Cria um novo "esqueleto" de pseudocódigo, substituindo o
> texto existente no editor. Se este texto anterior tiver sido
> modificado, o VisuAlg pedirá sua confirmação para salvá-lo antes que
> seja sobreposto.
> 
> **Abrir:** Abre o texto de um pseudocódigo anteriormente gravado,
> substituindo o texto existente no editor. Se este tiver sido
> modificado, o VisuAlg pedirá sua confirmação para salvá-lo antes que
> seja sobreposto.
> 
> **Salvar:** Salva imediatamente o texto presente no editor. Caso seja
> a primeira vez que um novo texto é gravado, o VisuAlg pedirá o nome do
> arquivo e sua localização.
> 
> **Salvar como:** Permite salvar o texto presente no editor exibindo
> antes uma janela na qual se pode escolher o nome do arquivo e sua
> localização.
> 
> **Enviar por email:** Permite o envio por email do texto presente no
> editor.
> 
> **Imprimir:** Permite a impressão do algoritmo corrente, mostrando
> antes a janela de configuração de impressão (o correspondente botão da
> barra de tarefas imprime imediatamente o texto do pseudocódigo na
> impressora padrão).
> 
> **Sair:** Abandona o VisuAlg.
> 
> Além destes comandos, há ainda a lista dos 5 últimos algoritmos
> utilizados, que podem ser abertos diretamente ao se escolher o seu
> nome.

**Editar:** Além dos conhecidos comandos de um editor de texto (copiar,
cortar, colar, desfazer, refazer, selecionar tudo, localizar, localizar
de novo, substituir), há também as seguintes opções:

> **Corrigir indentação:** Corrige automaticamente a *indentação* do 
> pseudocódigo, tabulando cada comando interno com espaços à esquerda.
> **Gravar bloco de texto:** Permite a gravação em arquivo de um texto
> selecionado no editor. A extensão sugerida para o nome do arquivo é
> *.inc*.
> **Inserir bloco de texto:** Permite a inserção do conteúdo de um
> arquivo. A extensão sugerida para o nome do arquivo é *.inc*.

**Exibir:** Possui os comandos para ativar/desativar as seguintes
características:

> **Número de linhas:** Ativa/desativa a exibição da numeração das
> linhas na área à esquerda do editor. A numeração corrente da posição
> do cursor também é mostrada na primeira parte da barra de status,
> situada na parte inferior da tela. Por motivos técnicas, a numeração é
> desativada durante a execução do pseudocódigo, voltando à situação
> anterior logo em seguida.
> **Variáveis modificadas:** Ativa/desativa a exibição da variável que
> está sendo modificada. Como o número de variáveis pode ser grande,
> muitas podem estar fora da janela de visualização; quando esta
> característica está ativada, o VisuAlg rola a grade de exibição de
> modo que cada variável fique visível no momento em está sendo
> modificada. Este recurso é especialmente útil quando se executa um
> pseudocódigo passo a passo. Por questões de desempenho, a configuração
> padrão desta característica é *desativada,* quando o pseudocódigo está
> sendo executado automaticamente. No entanto, basta clicar este botão
> para executá-lo automaticamente com a exibição ativada. No final da
> execução, a configuração volta a ser *desativada*.

**Pseudocódigo:** Contém os comandos relativos à execução do algoritmo:

> **Executar:** Inicia (ou continua) a execução automática do
> pseudocódigo.
> **Passo a passo:** Inicia (ou continua) a execução linha por linha do
> pseudocódigo, dando ao usuário a oportunidade de acompanhar o fluxo de
> execução, os valores das variáveis e a pilha de ativação dos
> subprogramas.
> **Executar com *timer*:** Insere um atraso (que pode ser especificado)
> antes da execução de cada linha. Também realça em fundo azul o comando
> que está sendo executado, da mesma forma que na execução passo a
> passo.
> **Parar:** Termina imediatamente a execução do pseudocódigo.
> Evidentemente, este item fica desabilitado quando o pseudocódigo não
> está sendo executado.
> **Liga/desliga *breakpoint*:** Insere/remove um ponto de parada na
> linha em que esteja o cursor. Estes pontos de parada são úteis para a
> depuração e acompanhamento da execução dos pseudocódigos, pois
> permitem a verificação dos valores das variáveis e da pilha de
> ativação de subprogramas.
> **Desmarcar todos os *breakpoints*:** Desativa todos os *breakpoints*
> que estejam ativados naquele momento.
> **Executar em modo DOS:** Com esta opção ativada, tanto a entrada como
> a saída-padrão passa a ser uma janela que imita o DOS, simulando a
> execução de um programa neste ambiente.
> **Gerar valores aleatórios:** Ativa a geração de valores aleatórios
> que substituem a digitação de dados. A faixa padrão de valores gerados
> é de 0 a 100 inclusive, mas pode ser modificada. Para a geração de
> dados do tipo caractere, não há uma faixa pré-estabelecida: os dados
> gerados serão sempre *strings* de 5 letras maiúsculas.
> **Perfil:** Após a execução de um pseudocódigo, exibe o número de
> vezes que cada umas das suas linhas foi executada. É útil para a
> análise de eficiência (por exemplo, nos métodos de ordenação).
> **Pilha de ativação:** Exibe a pilha de subprogramas ativados num dado
> momento. Convém utilizar este comando em conjunto com *breakpoints* ou
> com a execução passo a passo.

**Linguagens:** Permite a tradução automático do pseudocódigo presente
no editor para outras linguagens de programação. Atualmente, apenas a
tradução para Pascal está implementada, mas ainda em fase de testes.

**Ferramentas:** Neste menu, é possível configurar algumas opções do
VisuAlg: cores e tipos de letras na exibição do pseudocódigo, número de
espaços para indentação automática, etc.

**Ajuda:** Entre outras coisas, possibilita acesso às páginas de ajuda e
às informações sobre o VisuAlg.

[Objetivos](objetivos.htm.md)
[Tela principal](telaprin.htm.md)
[Menu](menu.htm.md)
[A linguagem do VisuAlg](linguagem.htm.md)
[Referências da linguagem do VisuAlg](refer.htm.md)
[Mais recursos](autocomp.htm.md)
