import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {

  // Controllers para o os TextFields
  final void Function(String, double) onSubmit;

  TransactionForm( this.onSubmit );

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
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
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor R\$'),
              // No IOS o tipo number tras apenas numeros, por isso usamos numberWithOptions
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              controller: valueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: _submitForm,
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

  void _submitForm() {

    final title = titleController.text;
    final value = double.tryParse( valueController.text ) ?? 0.0;

    if ( title.isEmpty || value <= 0 ){
      return;
    }

    widget.onSubmit( title, value );
  }
}
