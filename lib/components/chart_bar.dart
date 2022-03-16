import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({this.label = '', this.value = 0, this.percentage = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 14,
          child: FittedBox(
            child: Text(value.toStringAsFixed(2)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF05445C),
                      width: 1.3,
                    ),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(label)
      ],
    );
  }
}
