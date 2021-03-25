import 'dart:math';

import 'package:expenses/components/transaction/transaction_form.dart';
import 'package:expenses/components/transaction/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {

  final _transactions = [
    Transaction(
        id: "t1", title: "Conta de Luz", value: 220.53, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: "Escola Adventista",
        value: 912.56,
        date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Passa a funcao da classe pai que sera executada pela classe filha
        // Nesse caso para atualizar o estado da lista de transacoes
        TransactionForm( _addTransaction ),
        TransactionList(_transactions),
      ],
    );
  }

  _addTransaction(String title, double value){

    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now() );

    setState( () {
      _transactions.add( newTransaction );
    });
  }

}
