import 'package:expenses/components/transaction/transaction_form.dart';
import 'package:expenses/components/transaction/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatelessWidget {

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
        TransactionList( _transactions ),
        TransactionForm(),
      ],
    );
  }

}
