import pytest

@pytest.fixture(scope="function")
def fixture_function():
    return 10

@pytest.fixture(scope="module")
def fixture_module():
    return 20

@pytest.fixture(scope="session")
def fixture_session():
    return 40

def test_1(fixture_function):
    assert fixture_function == 10

def test_2(fixture_function,fixture_module):
    assert fixture_function == 10
    assert fixture_module == 20

def test_3(fixture_module, fixture_session):
    assert fixture_module == 20
    assert fixture_session == 40


    