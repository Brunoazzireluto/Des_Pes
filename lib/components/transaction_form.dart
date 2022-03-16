import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedDate == null){
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR')
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'título',
              ),
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              controller: valueController,
              keyboardType:const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'Nenhuma data Selecionada' 
                      :'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                      ),
                  ),
                  TextButton(
                    child: const Text('Selecionar Data'), 
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline),
                  onPressed: _submitForm,
                  label: const Text('Adicionar Transação'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
