import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {

  // Controllers para o os TextFields
  final titleController = TextEditingController();
  final valueController = TextEditingController();

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
                    print(titleController.text);
                    print(valueController.text);
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
