def is_positive(numero):
    return numero > 0

def test_eh_positivo():
    assert is_positive(5) is True
    assert is_positive(-5) is False 