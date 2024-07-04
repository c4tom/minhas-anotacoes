from funcoes import *

def test_email_valido():
    assert email_valido("exemplo@dominio.com") is True
    assert email_valido("exemplo.com") is False

'''
def test_dividir():
    assert dividir(4,2) == 2
    assert dividir(4,0) is None
'''