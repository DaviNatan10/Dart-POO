import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cervejas',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cervejas'),
        ),
        body: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Nome',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Estilo',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'IBU',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: const <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('La Fin Du Monde')),
                  DataCell(Text('Bock')),
                  DataCell(Text('65')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Sapporo Premium')),
                  DataCell(Text('Sour Ale')),
                  DataCell(Text('54')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Duvel')),
                  DataCell(Text('Pilsner')),
                  DataCell(Text('82')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('IPA')),
                  DataCell(Text('IPA')),
                  DataCell(Text('70')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Stella Artois')),
                  DataCell(Text('Pilsner')),
                  DataCell(Text('30')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Guinness')),
                  DataCell(Text('Stout')),
                  DataCell(Text('45')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Heineken')),
                  DataCell(Text('Pilsner')),
                  DataCell(Text('22')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Paulaner')),
                  DataCell(Text('Hefeweizen')),
                  DataCell(Text('12')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Chimay Blue')),
                  DataCell(Text('Belgian Strong Dark Ale')),
                  DataCell(Text('75')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Red Stripe')),
                  DataCell(Text('Lager')),
                  DataCell(Text('20')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}