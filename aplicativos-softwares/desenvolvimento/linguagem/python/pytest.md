# PyTests

pytest.org

## Tipos de Testes


| Tipo de Teste          | Descrição                                                                                                         |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Testes Unitários      | Verifica se unidades individuais de código (como funções ou métodos) funcionam conforme o esperado.             |
| Testes de Integração | Testa a integração entre diferentes módulos ou componentes do software para garantir seu funcionamento conjunto. |
| Testes de Sistema      | Testa o sistema como um todo para verificar se atende aos requisitos funcionais e não funcionais especificados.    |
| Testes de Aceitação  | Validam se o software atende aos critérios de aceitação definidos pelos usuários finais.                        |
| Testes de Regressão   | Verifica se as alterações no código não introduzem defeitos em funcionalidades previamente testadas.            |
| Testes de Desempenho   | Avalia o desempenho do software em termos de tempo de resposta, uso de recursos, escalabilidade, etc.               |
| Testes de Carga        | Avalia o comportamento do sistema sob cargas de trabalho normais ou pesadas para determinar limites e gargalos.     |
| Testes de Stress       | Testa os limites do sistema submetendo-o a cargas extremamente altas ou condições adversas.                       |
| Testes de Segurança   | Avalia a segurança do software, identificando e corrigindo vulnerabilidades que podem ser exploradas.              |
| Testes de Usabilidade  | Avalia a facilidade de uso, eficiência e satisfação do usuário ao interagir com o software.                     |
| Testes End To End      | Testa o fluxo completo de ponta a ponta do sistema, simulando o uso real do usuário em diferentes cenários.       |


## Ambiente

- Python 3.5+
- Vscode
- Não usar Notebooks (jupyter, etc)

## Estrutura de Pastas Recomendadas

test_*.py

Executar: `python -m pytest`


## Definições

**Assert**: Um assert é uma declaração que espera um resultado específico durante a execução de um teste. Se o resultado esperado não for obtido, o assert falhará, indicando que algo está errado no código ou nos dados de teste. Essa é uma parte essencial dos testes automatizados, pois ajuda a identificar falhas e problemas no software.

```
# Função a ser testada
def somar(a, b):
    return a + b

# Teste usando pytest
def test_soma_numeros_positivos():
    resultado = somar(3, 5)
    assert resultado == 8  # Assert para verificar se a soma é igual a 8

def test_soma_numeros_negativos():
    resultado = somar(-3, -7)
    assert resultado == -10  # Assert para verificar se a soma é igual a -10

```

## Dicas

Para testes com banco de dados, ter um banco de dados só para testes, pois vai produzir lixos, como *inserts*, *updates*, etc
