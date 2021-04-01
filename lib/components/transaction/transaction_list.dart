import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // Outra forma de habilitar o scroll na teLa, mas o componente pai deve
      // ter um tamanho definido o Scaffold possui esse comportamento de tamanho
      // pre definido, senao o scroll nao sabe  calcular qdo realizar o scroll

      // O listView permite fazer loading da lista sob demanda
      child: transactions.isEmpty
          ? showMessageEmptyTransactionList(context)
          : showTransactionList(context),
    );
  }

  ListView showTransactionList(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];
        // Mapeia cada elemento da lista para um widget Card e
        // devolve uma lista pq estamos usando children
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
                      color: Theme.of(context).primaryColor),
                )),
            // Container da Descricao e data
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('${tr.title}',
                    style: Theme.of(context).textTheme.headline6),
                Text(
                  // Formata a data usando a biblioteca intl
                  DateFormat('d MMM y').format(tr.date),
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ))
          ],
        ));
      },
    );
  }

  Column showMessageEmptyTransactionList(BuildContext context) {
    return Column(
      children: <Widget>[
        // Adiciona espaco de 20 antes do componente
        SizedBox( height: 30 ),
        Text(
          'Nenhuma transação cadastrada',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox( height: 30 ),
        // Incluido container para que seja possivel delimitar o tamanho
        // e assim podemos usar o BoxFit.cover
        Container(
          height: 200,
          child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
        ),
      ],
    );
  }
}
