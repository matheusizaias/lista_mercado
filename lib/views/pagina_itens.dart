import 'package:app_lista_compras/Models/itens2.model.dart';
import 'package:app_lista_compras/Models/itens.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaItens extends StatefulWidget {
  @override
  _PaginaItensState createState() => _PaginaItensState();
}

class _PaginaItensState extends State<PaginaItens> {
  final repository = ItensRepository();
  final repository2 = ItensRepository2();

  final _formKey = GlobalKey<FormState>();
  final _item = Itens();
  final _repository = ItensRepository();
  final _repository2 = ItensRepository2();
  bool vazia = false;
  List<Itens> itens;
  List<Itens2> itens2;
  @override
  initState() {
    super.initState();
    this.itens = repository.read();
    this.itens2 = repository2.read();
    if (itens2.isEmpty == true) {
      vazia = true;
    }
    int cont = 0;
    int aux = 0;
    int i, y;
    if (itens2.isEmpty == false) {
      for (i = 0; i < itens.length; i++) {
        cont = 0;
        for (y = 0; y < itens2.length; y++) {
          if (itens[i].texto == itens2[y].texto) {
            cont += 1;
          }
        }
        if (cont == 0) {
          itens[i].ativo = false;
        }
      }
    }
    this.itens = repository.read();
  }

  Future<bool> confirmarExclusao(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Item excluido"),
          actions: [
            FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ],
        );
      },
    );
  }

  Future<bool> confirmarEdicao(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Item excluido"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool> vereficaAdd(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Item ja adicionado"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  bool itemAdd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ITENS"),
        centerTitle: true,
        // backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (vazia == false)
                Navigator.of(context).pushNamed('/lista');
              else
                Navigator.of(context).pushNamed('/fake');
            }),
        actions: [
          FlatButton(
            child: Text(
              "Adicionar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => setState(() => itemAdd = !itemAdd),
          ),
        ],
      ),
      // ignore: missing_return
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (_, indice) {
          var iten = itens[indice];
          return Dismissible(
            key: Key(iten.texto),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              print(direction == DismissDirection.endToStart);
              print(direction == DismissDirection.startToEnd);
              if (direction == DismissDirection.startToEnd) {
                repository.delete(iten.texto);
                setState(() => this.itens.remove(iten));
              }
            },
            // ignore: missing_return
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                return confirmarExclusao(context);
              } else
                Navigator.of(context).pushNamed('/edit', arguments: iten);
            },
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(30, 10, 0, 10),
              title: Row(
                children: [
                  itemAdd
                      ? IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () async {
                            if (iten.ativo == false) {
                              await Navigator.of(context).pushNamed(
                                '/add2',
                                arguments: iten,
                              );
                            } else
                              vereficaAdd(context);
                          },
                        )
                      : Container(),
                  Text(
                    iten.texto,
                    style: TextStyle(
                      fontSize: 25,
                      decoration: iten.ativo
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var result = await Navigator.of(context).pushNamed('/add');
          if (result == true) {
            setState(() {
              this.itens = repository.read();
            });
          }
        },
        label: Text('Adicionar Itens Novos'),
        icon: Icon(Icons.add_box_rounded),
      ),
    );
  }
}
