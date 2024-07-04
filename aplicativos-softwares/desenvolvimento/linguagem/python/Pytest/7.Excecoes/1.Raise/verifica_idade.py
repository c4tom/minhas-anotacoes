def verifica_idade(idade):
    if idade < 18:
        raise ValueError("Acesso negado para menores de 18 anos")
    return "Acesso Permitido"