import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum TableStatus { idle, loading, ready, error }
enum ItemType { beer, coffee, nation, none }

class DataService {
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;
  ItemType _selectedItem = ItemType.none;

  set numberOfItems(n) {
    _numberOfItems = n < 0 ? MIN_N_ITEMS : n > MAX_N_ITEMS ? MAX_N_ITEMS : n;
  }

   int get numberOfItems {
    return _numberOfItems;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier =
      ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  void carregar(index) {
    final funcoes = [
      () => carregarItens(ItemType.coffee, "api/coffee/random_coffee", ["blend_name", "origin", "variety"], ["Nome", "Origem", "Tipo"]),
      () => carregarItens(ItemType.beer, "api/beer/random_beer", ["name", "style", "ibu"], ["Nome", "Estilo", "IBU"]),
      () => carregarItens(ItemType.nation, "api/nation/random_nation", ["nationality", "capital", "language", "national_sport"], ["Nome", "Capital", "Idioma", "Esporte"]),
    ];
    funcoes[index]();
    _selectedItem = ItemType.values[index];
  }

  void carregarItens(ItemType itemType, String apiPath, List<String> propertyNames, List<String> columnNames) {
    // Ignorar solicitação se uma requisição já estiver em curso
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != itemType) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': itemType
      };
    }

    var uri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: apiPath,
      queryParameters: {'size': '$_numberOfItems'},
    );

    http.read(uri).then((jsonString) {
      var itemsJson = jsonDecode(jsonString);

      // Se já houver itens no estado da tabela...
      if (tableStateNotifier.value['status'] != TableStatus.loading) {
        itemsJson = [...tableStateNotifier.value['dataObjects'], ...itemsJson];
      }

      tableStateNotifier.value = {
        'itemType': itemType,
        'status': TableStatus.ready,
        'dataObjects': itemsJson,
        'propertyNames': propertyNames,
        'columnNames': columnNames,
      };
    });
  }
}

final dataService = DataService();
