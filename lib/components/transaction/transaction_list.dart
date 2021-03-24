import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      // Mapeia cada elemento da lista para um widget Card e
      // devolve uma lista pq estamos usando children
      children: transactions.map((tr) {
        return Card(
            child: Row(
          children: <Widget>[
            // Container do Preco
            Container(
                // Espacamento interno ao container, mas o mais proximo da borda
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2)),

                // Similar ao padding do html, espacamento sobre o conteudo
                padding: EdgeInsets.all(10),
                child: Text(
                  'R\$ ${tr.value.toStringAsFixed(2)}',
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
                Text('${tr.title}',
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
    );
  }
}
