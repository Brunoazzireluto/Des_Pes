import 'package:des_pes/components/chart.dart';
import 'package:des_pes/components/transaction_form.dart';
import 'package:des_pes/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';
import 'models/transaction.dart';

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary:  const Color(0xFF05445C),
            secondary: const Color(0xFFF2317F),
          ),
          textTheme: theme.textTheme.copyWith(
              headline6: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Transaction> _transactions = [];
  bool _ShowChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
        title: Text(
            'Despesas Pessoais',
            style: TextStyle(
              fontSize: 20 * mediaQuery.textScaleFactor,
            ),
            ),
        actions: [
          if( isLandscape)
            IconButton(
            icon: Icon(_ShowChart ? Icons.list : Icons.bar_chart),
            onPressed: () {
              setState(() {
                _ShowChart = !_ShowChart;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ]
      );
    final availableHeight = mediaQuery.size.height - appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(_ShowChart || !isLandscape )
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7: 0.3),
                child: Chart(_recentTransactions),
              ),
            if(!_ShowChart || !isLandscape )
              SizedBox(
                height: availableHeight * ( isLandscape ? 1:  0.7),
                  child: TransactionList(
                    _transactions,
                    _removeTransaction
                )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: const Color(0xFF05445C),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
