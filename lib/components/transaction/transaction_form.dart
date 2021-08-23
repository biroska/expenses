import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  // Controllers para o os TextFields
  final void Function(String, double, DateTime ) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Envolvemos o formulario em um ScrollView e definimos o padding bottom,
    // para evitar o overflow do teclado sobre os campos do fomulario
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(top:10, right: 10, left: 10, bottom: 10 + MediaQuery.of(context).viewInsets.bottom ),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor R\$'),
                // No IOS o tipo number tras apenas numeros, por isso usamos numberWithOptions
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                  ),
                  TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Nova Transação'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null ) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }
}
