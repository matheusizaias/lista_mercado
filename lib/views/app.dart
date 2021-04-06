import 'package:app_lista_compras/views/pagina_inicial.dart';
import 'package:app_lista_compras/views/pagina_itens.dart';
import 'package:app_lista_compras/views/pagina_lista.dart';
import 'package:app_lista_compras/views/pagina_lista_fake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_itens.dart';
import 'add_pagina.dart';
import 'edit_pagina.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // método responsável por desenhar a tela do aplicativo.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),

      //home: ListaPage(),
      routes: {
        '/': (context) => PaginaInicial(),
        '/lista': (context) => PaginaLista(),
        '/itens': (context) => PaginaItens(),
        '/add': (context) => AddItens(),
        '/add2': (context) => AddPag(),
        '/fake': (context) => PaginaListaFake(),
        '/edit': (context) => EditPag(),
      },
      initialRoute: '/',
    );
  }
}
