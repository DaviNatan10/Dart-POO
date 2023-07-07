abstract class Decididor{

  bool precisaTrocarAtualPeloProximo(dynamic atual, dynamic proximo);

}

class Ordenador{
List ordenarFuderoso(List objetos, Function(dynamic, dynamic) callback) {
    List objetosOrdenados = List.of(objetos);

    bool trocouAoMenosUm;

    do {
      trocouAoMenosUm = false;

      for (int i = 0; i < objetosOrdenados.length - 1; i++) {
        var atual = objetosOrdenados[i];
        var proximo = objetosOrdenados[i + 1];

        if (callback(atual, proximo) > 0) {
          var aux = objetosOrdenados[i];
          objetosOrdenados[i] = objetosOrdenados[i + 1];
          objetosOrdenados[i + 1] = aux;
          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return objetosOrdenados;
  }
}
