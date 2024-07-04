def calculate_total(price,discount_rate,tax_rate):
    discount = price * discount_rate
    tax = (price - discount) * tax_rate
    total = price - discount + tax
    return round(total,2)