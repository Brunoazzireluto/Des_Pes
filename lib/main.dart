import 'package:des_pes/components/transaction_form.dart';
import 'package:des_pes/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'models/transaction.dart';


void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
// Button color = 0xFF5C4F74
// Detaisl = 0xFFF2317F

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: const Color(0xFFF2317F)))),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final _transactions = [
    Transaction(
        id: 't1',
        title: 'primeira transação',
        value: 123.98,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'segunda transação',
        value: 456.30,
        date: DateTime.now()),
  ];

    _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }


  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF05445C),
          title: const Text('Despesas Pessoais'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: const Card(
                  color: Color(0xFFF2317F),
                  child: Text('Gráfico'),
                  elevation: 5,
                ),
              ),
              TransactionList(_transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), 
          onPressed: () => _openTransactionFormModal(context),
          backgroundColor: const Color(0xFFF2317F) ,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
        );
  }
}
