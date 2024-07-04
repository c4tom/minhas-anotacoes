import pytest
from soma import soma

@pytest.mark.parametrize("a,b,esperado",[
    (1,2,3),(4,5,9),(10,20,30)])
def test_soma(a,b,esperado):
    assert soma(a,b) == esperado