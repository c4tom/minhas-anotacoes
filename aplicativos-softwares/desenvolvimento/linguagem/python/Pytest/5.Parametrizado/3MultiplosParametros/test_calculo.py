import pytest
from calcula_total import calculate_total

@pytest.mark.parametrize("price",[10.00,50.00,100.00])
@pytest.mark.parametrize("discount_rate",[0,0.1,0.25])
@pytest.mark.parametrize("tax_rate",[0,0.05,0.1])
def test_calculate_total(price,discount_rate,tax_rate):
    expected_discount = price * discount_rate
    expected_tax = (price - expected_discount) * tax_rate
    expected_total = price - expected_discount + expected_tax

    assert calculate_total(price,discount_rate,tax_rate) == round(expected_total,2)
