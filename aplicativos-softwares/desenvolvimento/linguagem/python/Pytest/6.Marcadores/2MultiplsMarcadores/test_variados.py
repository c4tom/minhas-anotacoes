import pytest
import time

@pytest.mark.rapido
def test_soma_rapida():
    assert 1 + 2 == 3

@pytest.mark.lento
def test_soma_lenta():
    time.sleep(2)
    assert 1 + 2 == 3

@pytest.mark.rapido
@pytest.mark.lento
def test_soma_mista():
    time.sleep(1)
    assert 1 + 2 == 3