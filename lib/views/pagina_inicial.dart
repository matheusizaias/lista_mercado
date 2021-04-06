import 'package:app_lista_compras/Models/itens2.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String image = "assets/images/logo.png";
  final repository = ItensRepository2();
  bool vazia = false;
  List<Itens2> itens;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.itens = repository.read();
    if (itens.isEmpty == true) {
      vazia = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mercado Matheus"),
        centerTitle: true,
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pushNamed('/'),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Image.asset(image),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                  textColor: Colors.black,
                  height: 80.0,
                  color: Colors.yellow,
                  onPressed: () {
                    if (vazia == false)
                      Navigator.of(context).pushNamed('/lista');
                    else
                      Navigator.of(context).pushNamed('/fake');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Text(
                        'INICIAR COMPRA',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
