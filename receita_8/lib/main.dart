import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  MyApp app = MyApp();

  runApp(app);
}

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({'status': TableStatus.idle, 'dataObjects': []});

  void carregar(index) {
    final funcoes = [
      carregarCafes,
      carregarCervejas,
      carregarNacoes,
      carregarEnderecos
    ];
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': []
    };

    funcoes[index]();
  }

  void carregarCafes() {
    var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': '10'},
    );

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["blend_name", "origin", "uid"],
        'columnNames': ["Nome", "Origem", "UID"],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
      };
      print('$error');
    });
  }

  Future<void> carregarNacoes() async {
    try {
      var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/nation/random_nation',
        queryParameters: {'size': '10'},
      );

      var jsonString = await http.read(beersUri);
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["nationality", "language", "capital"],
        'columnNames': ["Nome", "Língua", "Capital"],
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
      };
      print('$error');
    }
  }

  void carregarCervejas() {
    var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/beer/random_beer',
        queryParameters: {'size': '10'});

    http.read(beersUri).then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["name", "style", "ibu"],
        'columnNames': ["Nome", "Origem", "UID"],
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
      };
      print('$error');
    });
  }

  Future<void> carregarEnderecos() async {
    try {
      var beersUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/v2/addresses',
        queryParameters: {'size': '10'},
      );

      var jsonString = await http.read(beersUri);
      var beersJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': beersJson,
        'propertyNames': ["city", "country", "community"],
        'columnNames': ["Cidade", "País", "Comunidade"],
      };
    } catch (error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
      };
      print('$error');
    }
  }
}

final dataService = DataService();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("DICAS E INFORMAÇÕES"),
        ),
        body: ValueListenableBuilder(
          valueListenable: dataService.tableStateNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.idle:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://st3.depositphotos.com/1013513/14494/i/450/depositphotos_144942899-stock-photo-young-business-man-waiting-for.jpg',
                        height: 200,
                      ),
                      SizedBox(height: 16),
                      const Text(
                        "Clique em algum dos botões abaixo.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                );
              case TableStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case TableStatus.ready:
                return ListView(
                  children: [
                    DataTableWidget(
                      jsonObjects: value['dataObjects'],
                      columnNames: value['columnNames'],
                      propertyNames: value['propertyNames'],
                    ),
                  ],
                );

              case TableStatus.error:
                return const Center(
                  child: Text(
                    'Erro ao carregar... Por favor, verificar sua conexão com a internet!',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                );
            }

            return Text("...");
          },
        ),
        bottomNavigationBar:
            NewNavBar(itemSelectedCallback: dataService.carregar),
      ),
    );
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;

          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.brown,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined)),
          BottomNavigationBarItem(
              label: "Endereços", icon: Icon(Icons.add_location_alt_outlined)),
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List<dynamic> jsonObjects;
  final List<dynamic> columnNames;
  final List<dynamic> propertyNames;

  DataTableWidget({
    this.jsonObjects = const [],
    this.columnNames = const ["Nome", "Estilo", "IBU"],
    this.propertyNames = const ["name", "style", "ibu"],
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnNames
          .map(
            (name) => DataColumn(
              label: Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          )
          .toList(),
      rows: jsonObjects
          .map(
            (obj) => DataRow(
              cells: propertyNames
                  .map(
                    (propName) => DataCell(
                      Text(obj[propName].toString()),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}