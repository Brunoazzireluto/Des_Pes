import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({this.label = '', this.value = 0, this.percentage = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(value.toStringAsFixed(2)),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
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
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(label))
            )
          ],
        );
      }

    );
  }
}
