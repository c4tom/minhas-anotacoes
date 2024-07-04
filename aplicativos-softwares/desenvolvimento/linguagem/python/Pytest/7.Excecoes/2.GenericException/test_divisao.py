import pytest
from divisao import dividir

def test_dividir_por_zero():
    with pytest.raises(ZeroDivisionError):
        dividir(10,0)

def test_dividir_por_zero2():
    with pytest.raises(ZeroDivisionError) as exec_info:
        dividir(10,0)
    assert "Não é possível dividir por zero." in str(exec_info)
    
        