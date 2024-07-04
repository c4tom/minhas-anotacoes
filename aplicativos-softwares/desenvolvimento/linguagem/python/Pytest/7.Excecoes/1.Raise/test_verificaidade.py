import pytest
from verifica_idade import verifica_idade

def test_verifica_idade_com_erro():
    with pytest.raises(ValueError):
        verifica_idade(17)

def test_verifica_idade_sem_erro():
    assert verifica_idade(20) == "Acesso Permitido"