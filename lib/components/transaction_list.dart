import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                          'R\$ ${tr.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.white, 
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6 ,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date)
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_rounded),
                      onPressed: () => onRemove(tr.id) ,
                      color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                );
              },
            ),
    );
  }
}
