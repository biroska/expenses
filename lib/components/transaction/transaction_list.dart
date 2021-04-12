import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

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

        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                        child: Text('R\$${tr.value.toStringAsFixed(2)}'))),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(DateFormat('d MMM y').format(tr.date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () => onRemove( tr.id ),
              )),
        );
      },
    );
  }

  Column showMessageEmptyTransactionList(BuildContext context) {
    return Column(
      children: <Widget>[
        // Adiciona espaco de 20 antes do componente
        SizedBox(height: 30),
        Text(
          'Nenhuma transação cadastrada',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 30),
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
