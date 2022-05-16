import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:intl/intl.dart';

class adaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const adaptativeDatePicker(
      {Key? key, required this.selectedDate, required this.onDateChanged})
      : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),
            locale: const Locale('pt', 'BR'))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'Nenhuma data Selecionada'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
                ),
                TextButton(
                  child: const Text('Selecionar Data'),
                  onPressed: () => _showDatePicker(context),
                )
              ],
            ),
          );
  }
}
