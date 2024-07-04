from app import Produto,Estoque

def test_adicionar_verificar_quantidade():
    estoque = Estoque()

    produto1 = Produto("Mouse",10)
    produto2 = Produto("Teclado",5)

    estoque.adicionar_produto(produto1)
    estoque.adicionar_produto(produto2)

    assert estoque.verifica_quantidade("Mouse") == 10
    assert estoque.verifica_quantidade("Teclado") == 5

def test_adicionar_produto_existente():
    estoque = Estoque()

    produto1 = Produto("Mouse",10)
    estoque.adicionar_produto(produto1)

    produto2 = Produto("Mouse",5)
    estoque.adicionar_produto(produto2)

    assert estoque.verifica_quantidade("Mouse") == 15

