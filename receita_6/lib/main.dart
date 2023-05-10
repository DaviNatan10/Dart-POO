

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);

  var chaves = ["name", "style", "ibu"];
  var colunas = ["Nome", "Estilo", "IBU"];

  void carregar(index) {
    var funcoes = [
      carregarCafes,
      carregarCervejas,
      carregarNacoes,
    ];

    funcoes[index]();
  }

  void columnCafes() {
    chaves = ["name", "Origem", "Qualidade"];
    colunas = ["Nome", "Origem", "Qualidade"];
  }

  void columnCervejas() {
    chaves = ["name", "style", "ibu"];
    colunas = ["Nome", "Estilo", "IBU"];
  }

  void columnNacoes() {
    chaves = ["name", "População", "Moeda"];
    colunas = ["Nome", "População", "Moeda"];
  }

  void carregarCafes() {
    columnCafes();

    tableStateNotifier.value = [
      {"name": "Ouro Branco", "Origem": "Brásil", "Qualidade": "Otimo"},
      {"name": "Espresso", "Origem": "Brasil", "Qualidade": "Otimo"},
      {"name": "Santa Monica", "Origem": "Brásil", "Qualidade": "Media"}
    ];
  }

  void carregarCervejas() {
    columnCervejas();

    tableStateNotifier.value = [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
      {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
      {"name": "Duvel", "style": "Pilsner", "ibu": "82"}
    ];
  }

  void carregarNacoes() {
    columnNacoes();

    tableStateNotifier.value = [
      {"name": "Brasil", "População": "214,3 milhões", "Moeda": "Real"},
      {"name": "Argentina", "População": "45,81 milhões", "Moeda": "Peso"},
      {"name": "Uruguai", "População": "3,4 milhões", "Moeda": "Peso"}
    ];
  }
}

final dataService = DataService();

void main() {

  MyApp app = MyApp();

  runApp(app);

}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.deepPurple),

      debugShowCheckedModeBanner:false,

      home: Scaffold(

        appBar: AppBar( 

          title: const Text("Dicas"),

          ),

        body: ValueListenableBuilder(

          valueListenable: dataService.tableStateNotifier,

          builder:(_, value, __){

            return DataTableWidget(

              jsonObjects: value, 

              propertyNames: dataService.chaves, 

              columnNames: dataService.colunas,


            );

          }

        ),

        bottomNavigationBar: NewNavBar(itemSelectedCallback: dataService.carregar),

      ));

  }

}

class NewNavBar extends HookWidget {

  var itemSelectedCallback; //esse atributo será uma função

  NewNavBar({this.itemSelectedCallback}){

    itemSelectedCallback ??= (_){} ;

  } 

  @override

  Widget build(BuildContext context) {

    var state = useState(1);

    return BottomNavigationBar(

      onTap: (index){

        state.value = index;
        itemSelectedCallback(index);
         
      }, 

      currentIndex: state.value,

      items: const [

        BottomNavigationBarItem(

          label: "Cafés",

          icon: Icon(Icons.coffee_outlined),

        ),

        BottomNavigationBarItem(

            label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),

        BottomNavigationBarItem(label: "Nações", icon: Icon(Icons.flag_outlined))

      ]);

  }

}

class DataTableWidget extends StatelessWidget {

  final List jsonObjects;

  final List<String> columnNames;

  final List<String> propertyNames;

  DataTableWidget( {this.jsonObjects = const [], this.columnNames = const ["Nome","Estilo","IBU"], this.propertyNames= const ["name", "style", "ibu"]});

  @override

  Widget build(BuildContext context) {

    return DataTable(

      columns: columnNames.map( 

        (name) => DataColumn(

          label: Expanded(

            child: Text(name, style: TextStyle(fontStyle: FontStyle.italic))

          )

        )

    ).toList(),

      rows: jsonObjects.map( 

        (obj) => DataRow(

            cells: propertyNames.map(

              (propName) => DataCell(Text(obj[propName]))

            ).toList()

          )

        ).toList());
  }
}