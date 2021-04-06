import 'package:app_lista_compras/Models/itens2.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaginaLista extends StatefulWidget {
  @override
  _PaginaListaState createState() => _PaginaListaState();
}

class _PaginaListaState extends State<PaginaLista> {
  final repository = ItensRepository2();
  bool vazia = false;
  List<Itens2> itens;
  @override
  initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LISTA DE COMPRAS"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushNamed('/'),
        ),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (_, ativo) {
          var iten = itens[ativo];

          return Dismissible(
            key: Key(iten.texto),

            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              print(direction == DismissDirection.endToStart);
              print(direction == DismissDirection.startToEnd);
              repository.delete(iten.texto);
              setState(() {
                this.itens.remove(iten);
                if (itens.isEmpty) {
                  Navigator.of(context).pushNamed('/fake');
                }
              });
            },
            // ignore: missing_return
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                return confirmarExclusao(context);
              }
            },
            child: CheckboxListTile(
              contentPadding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              title: Row(
                children: [
                  Text(
                    iten.texto,
                    style: TextStyle(
                      color: iten.importante ? Colors.white : Colors.black,
                      backgroundColor:
                          iten.importante ? Colors.green : Colors.white,
                      fontSize: 25,
                      decoration: iten.ativo
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Text(
                    'Quantidade:  ' + iten.quantidade.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      decoration: iten.ativo
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              value: iten.ativo,
              onChanged: (value) {
                setState(() => iten.ativo = value);
                this.itens = repository.read();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var result = await Navigator.of(context).pushNamed('/itens');
          if (result == true) {
            setState(() {
              this.itens = repository.read();
            });
          }
        },
        label: Text('Adicionar Itens a Lista de Compras'),
        icon: Icon(Icons.add_box_rounded),
        backgroundColor: Colors.green,
      ),
    );
  }
}
