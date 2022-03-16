import 'dart:ffi';

import 'package:des_pes/components/chart_bar.dart';
import 'package:des_pes/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransaction{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );
      double totalSum = 0.0;
      for(var i = 0; i < recentTransactions.length; i++){
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if( sameDay && sameMonth && sameYear){
          totalSum += recentTransactions[i].value;
        }
      }
      

      return {
        'day': DateFormat.E().format(weekDay)[0], 
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weektotalValue {
    return groupedTransaction.fold(0.0, (sum, tr){
      return sum + (tr['value'] as num).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((tr) {
            var value = (tr['value'] as num).toDouble();
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(), 
                value: value,
                percentage: _weektotalValue == 0 ? 0 : value / _weektotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}