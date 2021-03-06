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
                headline6: TextStyle(
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
  bool _showChart = false;
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: "t0", title: "Conta Antiga", value: 220.53, date: DateTime.now().subtract( Duration(days:33) ) ),
    // Transaction(
    //     id: "t1", title: "Conta de Luz", value: 220.53, date: DateTime.now().subtract( Duration(days:2) ) ),
    // Transaction(
    //     id: "t2", title: "Escola Adventista", value: 912.56, date: DateTime.now().subtract( Duration(days:4) ) ),
    // Transaction(
    //     id: "t3", title: "Prestação Carro", value: 3500.56, date: DateTime.now() ),
    // Transaction(
    //     id: "t4", title: "Valor Muito Grande", value: 91200.56, date: DateTime.now().subtract( Duration( days:1 ) ) ),
  ];

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime transactionDate) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: transactionDate);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String transactionId) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == transactionId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    bool isLandscape =
        mediaQueryData.orientation == Orientation.landscape;

    // App bar extraido para variavel, para possibilitar a obtencao de sua altura,
    // via appBar.preferredSize.height
    AppBar appBar = AppBar(
      title: Text('Despesas Pessoais'),
      actions: <Widget>[
        if ( isLandscape ) manageCharAndListIcons(),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    return Scaffold(
      // App bar extraido para variavel, para possibilitar a obtencao de sua altura,
      // via appBar.preferredSize.height
      appBar: appBar,
      // Habilita o scroll na teLa, mas o componente pai deve ter um tamanho definido
      // O Scaffold possui esse comportamento de tamanho pre definido
      // Safe Area, garante que a aplicacao trabalhe em uma area segura, util para
      // evitar componente de tela/hardware, como o notch
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // Coloca espaco antes e depois dos componentes pq esta dentro de column
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // Estica os componetes
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Removida a linha do Switch pois incluimos essa opcao via icones no appBar
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text("Exibir Gráfico"),
              //       Switch(
              //           value: _showChart,
              //           onChanged: (value) {
              //             setState(() {
              //               _showChart = value;
              //             });
              //           }),
              //     ],
              //   ),
              // Os componentes chart e transactionList foam envolvidos com
              // Container para pode setar a altura maxima deles
              // A SOMA DAS ALTURAS, NAO PODE SUPERAR 100% DA ALTURA DISPONIVEL
              manageChartAndTransactionViews(isLandscape, appBar, mediaQueryData),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container manageChartAndTransactionViews(bool isLandscape, AppBar appBar, MediaQueryData mediaQueryData) {
    return Container(
      child: Column(
        children: <Widget>[
          if (_showChart || !isLandscape) manageChartView(appBar, isLandscape, mediaQueryData),
          if (!_showChart || !isLandscape) manageTransactionListView(appBar, isLandscape, mediaQueryData),
        ],
      ),
    );
  }

  Container manageTransactionListView(AppBar appBar, bool isLandscape, MediaQueryData mediaQueryData ) {
    return Container(
        height: !isLandscape
            ? _listPortraitView(appBar, mediaQueryData)
            : _listLandscapeView(appBar, mediaQueryData ),
        child: TransactionList(_transactions, _removeTransaction));
  }

  Container manageChartView(AppBar appBar, bool isLandscape, MediaQueryData mediaQueryData) {
    return Container(
        height: !isLandscape
            ? _chartPortraitView(appBar, mediaQueryData)
            : _chartLandscapeView(appBar, mediaQueryData),
        child: Chart(_recentTransactions));
  }

  IconButton manageCharAndListIcons() {

    if (_showChart) {
      return IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          });
    } else {
      return IconButton(
          icon: Icon(Icons.bar_chart_rounded),
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          });
    }
  }

  double availableHeight(AppBar appBar, MediaQueryData mediaQueryData) {
    final availableHeight = mediaQueryData.size.height -
        // AppBar com o titulo da App
        appBar.preferredSize.height -
        // Altura da barra de notificacao, relogio, bateria, ...
        mediaQueryData.padding.top;
    return availableHeight;
  }

  /// Funcao, que dado um appBar calcula a altura disponivel da tela
  /// A SOMA DAS ALTURAS, NAO PODE SUPERAR 100% DA ALTURA DISPONIVEL
  // @Deprecated("Utilizar as funcoes abaixo, especialidas pela orientacao")
  // Map<String, double> _componentRatio(AppBar appBar) {
  //   double availableHeight = this.availableHeight(appBar);
  //
  //   double _ratio = 0.75;
  //
  //   double _primary = _ratio * availableHeight;
  //   double _secondary = (1.0 - _ratio) * availableHeight;
  //
  //   return {'primary': _primary, 'secondary': _secondary};
  // }
  
 double _listLandscapeView(AppBar appBar, MediaQueryData mediaQueryData) {

    double availableHeight = this.availableHeight(appBar, mediaQueryData );

    return availableHeight * 0.95;
  }
  
 double _chartLandscapeView(AppBar appBar, MediaQueryData mediaQueryData) {

    double availableHeight = this.availableHeight(appBar, mediaQueryData);

    return availableHeight * 0.75;
  }

  double chartPortraitRatio = 0.27;
  /// Funcao, que dado um appBar calcula a altura disponivel da tela
  /// A SOMA DAS ALTURAS, NAO PODE SUPERAR 100% DA ALTURA DISPONIVEL
 double _chartPortraitView(AppBar appBar, MediaQueryData mediaQueryData) {

    double availableHeight = this.availableHeight(appBar, mediaQueryData);

    return availableHeight * chartPortraitRatio;
  }

  /// Funcao, que dado um appBar calcula a altura disponivel da tela
  /// A SOMA DAS ALTURAS, NAO PODE SUPERAR 100% DA ALTURA DISPONIVEL
  double _listPortraitView(AppBar appBar, MediaQueryData mediaQueryData) {

    double availableHeight = this.availableHeight(appBar, mediaQueryData );

    double listRatio = (1 - chartPortraitRatio );

    return availableHeight * listRatio;
  }

}
