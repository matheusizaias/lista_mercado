import 'package:app_lista_compras/Models/itens2.model.dart';
import 'package:app_lista_compras/Models/itens.model.dart';
import 'package:app_lista_compras/repositores/itens.repositores.dart';
import 'package:app_lista_compras/repositores/itens.repositores2.dart';
import 'package:flutter/material.dart';

enum importancia { maior, menor }
importancia _value = importancia.maior;

class AddPag extends StatefulWidget {
  @override
  _addPagState createState() => _addPagState();
}

class _addPagState extends State<AddPag> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _item = Itens2();
  final _repository = ItensRepository2();

  initState() {
    super.initState();
    //this.itens = repository.read();
  }

  onSave(BuildContext context) {
    if (_formKey.currentState.validate() && _formKey2.currentState.validate()) {
      _formKey.currentState.save();
      _formKey2.currentState.save();
      _formKey3.currentState.save();
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
          title: Text("Item Adicionado a sua lista!"),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pushNamed('/lista'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Itens itens = ModalRoute.of(context).settings.arguments;
    itens.ativo = true;

    if (_value == importancia.maior) {
      _item.importante = true;
    } else
      _item.importante = false;

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
            onPressed: () => onSave(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  enabled: false,
                  initialValue: itens.texto,
                  decoration: InputDecoration(
                    labelText: "Descrição",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _item.texto = value,
                  validator: (value) =>
                      value.isEmpty ? "Campo obrigatório" : null,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.fromLTRB(350, 0, 16, 20),
              child: Form(
                key: _formKey2,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Quantidade",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _item.quantidade = int.parse(value),
                  validator: (value) =>
                      value.isEmpty ? "Campo obrigatório" : null,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Qual a importância desse produto em sua compra?',
              style: TextStyle(fontSize: 20)),
          Flexible(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 16, 5),
              child: Form(
                key: _formKey3,
                child: RadioListTile<importancia>(
                  title: const Text('Alta'),
                  value: importancia.maior,
                  groupValue: _value,
                  onChanged: (importancia value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Form(
                key: _formKey4,
                child: RadioListTile<importancia>(
                  title: const Text('Baixa'),
                  value: importancia.menor,
                  groupValue: _value,
                  onChanged: (importancia value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
