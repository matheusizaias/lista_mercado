import 'package:app_lista_compras/Models/itens.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores.dart';
import 'package:flutter/material.dart';

class AddItens extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Itens();
  final _repository = ItensRepository();

  onSave(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      confirmarAdd(context);
    }
  }

  Future<bool> confirmarAdd(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("Item cadastrado!"),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("ADICIONAR ITEM"),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              "Salvar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
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
