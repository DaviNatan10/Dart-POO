import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/ordenador.dart';



enum TableStatus{idle,loading,ready,error}

enum ItemType{

   company , address, bank, none;

  String get asString => '$name';

  List<String> get columns => this == company? ["Numero Telefone", "Industria", "Endereço"] :

                              this == address? ["Cidade", "Rua", "Caixa Correios"]:

                              this == bank? ["Numero Conta", "Nome do  Banco", "numero de roteamento"]:

                              [] ;

  List<String> get properties => this == company? ["phone_number","industry","full_address"] :

                              this == address? ["city","street_name","mail_box"]:

                              this == bank? ["account_number","bank_name","routing_number"]:

                              [] ;

}



class DataService{



  static const MAX_N_ITEMS = 15;

  static const MIN_N_ITEMS = 3;

  static const DEFAULT_N_ITEMS = 7;

  

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n){
    _numberOfItems = n < 0 ? MIN_N_ITEMS: n > MAX_N_ITEMS? MAX_N_ITEMS: n;

  }

  final ValueNotifier<Map<String,dynamic>> tableStateNotifier 

                            = ValueNotifier({
                              'status':TableStatus.idle,
                              'dataObjects':[],
                              'itemType': ItemType.none
                            });

  

  void carregar(index){
    final params = [ItemType.bank, ItemType.address, ItemType.company];
    carregarPorTipo(params[index]);
  }

  void ordenarEstadoAtual(final String propriedade) {
    List objetos = tableStateNotifier.value['dataObjects'] ?? [];
    if (objetos == []) return;
    Ordenador ord = Ordenador();
    var objetosOrdenados =
        ord.ordenarFuderoso(objetos, (a, b) => a[propriedade].compareTo(b[propriedade]));
    emitirEstadoOrdenado(objetosOrdenados, propriedade);
  }


  Uri montarUri(ItemType type){
    return Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/${type.asString}/random_${type.asString}',
      queryParameters: {'size': '$_numberOfItems'});
  }



  Future<List<dynamic>> acessarApi(Uri uri) async{
    var jsonString = await http.read(uri);
    var json = jsonDecode(jsonString);
    json = [...tableStateNotifier.value['dataObjects'], ...json];
    return json;
  }


  void emitirEstadoOrdenado(List objetosOrdenados,String propiedade){
    var estado =Map<String,dynamic>.from(tableStateNotifier.value);
    estado['dataObjects'] = objetosOrdenados;
    estado['sortCriteria']= propiedade;
    estado['asceding']= true;
    tableStateNotifier.value= estado;
  }




  void emitirEstadoCarregando(ItemType type){
    tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': type
      };
  }

  void emitirEstadoPronto(ItemType type, var json){
    tableStateNotifier.value = {
        'itemType': type,
        'status': TableStatus.ready,
        'dataObjects': json,
        'propertyNames': type.properties,
        'columnNames': type.columns
      };
  }

  bool temRequisicaoEmCurso() => tableStateNotifier.value['status'] == TableStatus.loading;

  bool mudouTipoDeItemRequisitado(ItemType type) => tableStateNotifier.value['itemType'] != type;

  void carregarPorTipo(ItemType type) async{
    //ignorar solicitação se uma requisição já estiver em curso
    if (temRequisicaoEmCurso()) return;
    if (mudouTipoDeItemRequisitado(type)){
      emitirEstadoCarregando(type);
    }
    var uri = montarUri(type);
    var json = await acessarApi(uri);
    emitirEstadoPronto(type, json);
  }
}

final dataService = DataService();




class DecididorJson extends Decididor {
  final String propiedade;
  final bool crescente;
  DecididorJson(this.propiedade, [this.crescente = true]);

  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];
      return ordemCorreta[0][propiedade].compareTo(ordemCorreta[1][propiedade]) > 0;
    } catch (error) {
      return false;
    }
  }
}