import pytest

@pytest.fixture
def sample_list():
    return [1,2,3,4,5]

def test_sum(sample_list):
    assert sum(sample_list) == 15

def test_length(sample_list):
    assert len(sample_list) == 5