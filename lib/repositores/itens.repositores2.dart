import 'package:app_lista_compras/Models/itens2.model.dart';

class ItensRepository2 {
  static List<Itens2> itens2 = List<Itens2>();
  static List<Itens2> itens3 = List<Itens2>();

  // ItensRepository2() {
  //   if (itens2.isEmpty) {
  //     itens2.add(Itens2(id: "1", texto: "Barra de Chocolate", ativo: false));
  //   }
  // }

  void create(Itens2 item) {
    itens2.add(item);
  }

  List<Itens2> read() {
    int tamanho = itens2.length;
    itens3 = [];

    for (int i = 0; i < tamanho; i++) {
      if (itens2[i].ativo == false) {
        itens3.add(itens2[i]);
      }
    }
    for (int i = 0; i < tamanho; i++) {
      if (itens2[i].ativo == true) {
        itens3.add(itens2[i]);
      }
    }
    return itens3;
  }

  void delete(String texto) {
    final item = itens2.singleWhere((t) => t.texto == texto);
    itens2.remove(item);
  }
}
