# VSCODE

## Observações

- configurar formatar codigo ao colar

## Complementos

- Jupyter - Janela interativa, tipo de debug - [https://youtu.be/ol_S9G0nCNE?si=U2N1j7Qp_MBSoDhZ&t=571](https://youtu.be/ol_S9G0nCNE?si=U2N1j7Qp_MBSoDhZ&t=571)
- Autopep8 - Formatador de Codigo (configure formatar on save > setting > formater)
- ionutvmi.path-autocomplete - completar paths
- donjayamanne.python-environment-manager Gerenciador de ENV

# PIP

- freeze - Listar todas as bibliotecas do python
- pandas - ler CSV

# Desenvolvimento

## Criação de ENV

Use o virtualenv

```typescript
sudo apt install python3-virtualenv

# Ambiente de teste
virtualenv test-env
source test-env/bin/activate
pip install -r requirements

# Ambiente de Produção
virtualenv prod-env
source test-env/bin/activate
pip install -r requirements
```

# Referências

- [https://www.youtube.com/watch?v=ol_S9G0nCNE](https://www.youtube.com/watch?v=ol_S9G0nCNE)
  - Anaconda (versao do python)
  - VSCODE
    - Plugin
      - Python da MS
      - Jupyter
