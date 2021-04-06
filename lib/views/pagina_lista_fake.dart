import 'package:app_lista_compras/Models/itens2.model.dart';
import 'package:app_lista_compras/Models/itens.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:app_lista_compras/views/pagina_itens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaListaFake extends StatefulWidget {
  @override
  _PaginaListaFakeState createState() => _PaginaListaFakeState();
}

class _PaginaListaFakeState extends State<PaginaListaFake> {
  final repository = ItensRepository2();

  List<Itens2> itens;
  @override
  initState() {
    super.initState();
    this.itens = repository.read();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(130, 60, 20, 20),
            child: Text(
              "    Sua lista está \nvazia no momento!",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ],
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
        label: Text('Iniciar compra'),
        icon: Icon(Icons.add_box_rounded),
        backgroundColor: Colors.black,
      ),
    );
  }
}
