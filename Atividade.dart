void main() {
   Produto Cana = Produto(nome: "Cana", valor: 15, validade: "12/12/2023");
  Produto Carne = Produto(nome: "Carne", valor: 35, validade: "12/12/2023");
  

    Item cerveja = new Item(quantidade:5,produto:Cana);
    Item  carne = new Item(quantidade:4,produto: Carne);

   Venda venda = Venda(data: "13/03/2023", itens: [cerveja, carne, ]);
    print("O total da venda é: R\$${venda.total()}");

    


    
  
}

class Venda {
  String data;
  List<Item> itens = [];
  double total() => itens.fold(0, (sum, e) => sum + e.total());
  Venda({required this.data, required this.itens});

  void adicionarItem(Item item){
        itens.add(item);
    }
}





class Produto{
   String nome;
   double valor;
   String validade; 
   Produto({required this.nome, required this.valor, required this.validade});

}

class Item{
  double quantidade;
  Produto produto;

  double total() => quantidade * produto.valor;
  Item({required this.quantidade, required this.produto});
}
