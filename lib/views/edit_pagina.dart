import 'dart:collection';

import 'package:app_lista_compras/Models/itens.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:flutter/material.dart';

class EditPag extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Itens();
  final _repository = ItensRepository();

  onSave(BuildContext context, Itens itens) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.update(_item, itens);
      confirmarEdit(context);
    }
  }

  Future<bool> confirmarEdit(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Item alterado!"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pushNamed('/itens'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Itens itens = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("ITEM SELECIONADO"),
        centerTitle: false,
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text(
              "Salvar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onSave(context, itens),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: itens.texto,
            decoration: InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _item.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
      ),
    );
  }
}
