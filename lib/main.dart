import 'dart:math';

import 'package:flutter/material.dart';

import 'components/chart/chart.dart';
import 'components/transaction/transaction_form.dart';
import 'components/transaction/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaInicial(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "t0", title: "Conta Antiga", value: 220.53, date: DateTime.now().subtract( Duration(days:33) ) ),
    Transaction(
        id: "t1", title: "Conta de Luz", value: 220.53, date: DateTime.now().subtract( Duration(days:2) ) ),
    Transaction(
        id: "t2", title: "Escola Adventista", value: 912.56, date: DateTime.now().subtract( Duration(days:4) ) ),
    Transaction(
        id: "t3", title: "Prestação Carro", value: 3500.56, date: DateTime.now() ),
    Transaction(
        id: "t4", title: "Valor Muito Grande", value: 91200.56, date: DateTime.now().subtract( Duration( days:1 ) ) ),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  List<Transaction> get _recentTransactions{
    return _transactions.where( (tr) {
      return tr.date.isAfter( DateTime.now().subtract(Duration(days:7)) );
    }).toList();
  }

  _addTransaction(String title, double value, DateTime transactionDate ) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: transactionDate );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      // Habilita o scroll na teLa, mas o componente pai deve ter um tamanho definido
      // O Scaffold possui esse comportamento de tamanho pre definido
      body: SingleChildScrollView(
        child: Column(
          // Coloca espaco antes e depois dos componentes pq esta dentro de column
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Estica os componetes
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart( _recentTransactions ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
