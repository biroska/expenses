import 'package:flutter/material.dart';

import 'components/transaction/transaction_user.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaInicial(),
    );
  }
}

class PaginaInicial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          // Coloca espaco antes e depois dos componentes pq esta dentro de column
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // Estica os componetes
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              // Outra opcao para esticar os componentes
              // width:  double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            TransactionUser(),
          ],
        ));
  }
}