import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {

  // Controllers para o os TextFields
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  // Declaracao da funcao que passara os parametros para a classe pai
  // TransactionUser, no metodo _addTransaction
  final void Function(String, double) onSubmit;

  TransactionForm( this.onSubmit );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor R\$'),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    final title = titleController.text;
                    final value = double.tryParse( valueController.text ) ?? 0.0;
                    onSubmit( title, value );
                  },
                  textColor: Colors.purple,
                  child: Text('Nova Transação'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
