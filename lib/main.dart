import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          // Coloca espaco antes e depois dos componentes pq esta dentro de column
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            Column(
              // Mapeia cada elemento da lista para um widget Card e
              // devolve uma lista pq estamos usando children
              children: _transactions.map((tr) {
                return Card(
                    child: Row(
                  children: <Widget>[
                    // Container do Preco
                    Container(
                        // Espacamento interno ao container, mas o mais proximo da borda
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2)),

                        // Similar ao padding do html, espacamento sobre o conteudo
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${tr.value.toStringAsFixed( 2 )}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple),
                        )),
                    // Container da Descricao e data
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text( '${tr.title}',
                            style: TextStyle(
                                // color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        Text(
                          // Formata a data usando a biblioteca intl
                          DateFormat('d MMM y').format(tr.date),
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ))
                  ],
                ));
              }).toList(),
            )
          ],
        ));
  }
}
