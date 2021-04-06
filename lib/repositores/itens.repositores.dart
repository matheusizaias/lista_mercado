import 'package:app_lista_compras/Models/itens.model.dart';

class ItensRepository {
  static List<Itens> itens = List<Itens>();
  static List<Itens> itens2 = List<Itens>();

  ItensRepository() {
    if (itens.isEmpty) {
      itens.add(Itens(id: "1", texto: "Barra de Chocolate", ativo: false));
      itens.add(Itens(id: "2", texto: "Doritos", ativo: false));
      itens.add(Itens(id: "3", texto: "Coca Cola 2L", ativo: false));
      itens.add(Itens(id: "4", texto: "Pipoca", ativo: false));
    }
  }

  void create(Itens item) {
    itens.add(item);
  }

  List<Itens> read() {
    int tamanho = itens.length;
    itens2 = [];

    for (int i = 0; i < tamanho; i++) {
      if (itens[i].ativo == false) {
        itens2.add(itens[i]);
      }
    }
    for (int i = 0; i < tamanho; i++) {
      if (itens[i].ativo == true) {
        itens2.add(itens[i]);
      }
    }
    return itens2;
  }

  void delete(String texto) {
    final item = itens.singleWhere((t) => t.texto == texto);
    itens.remove(item);
  }

  void update(Itens newItem, Itens oldItem) {
    final item = itens.singleWhere((t) => t.texto == oldItem.texto);
    item.texto = newItem.texto;
  }
}
