// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentAmountPercentage;

  const ChartBar({
    required this.label,
    required this.spentAmount,
    required this.spentAmountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(children: [
        Container(
          height: constraints.maxHeight * 0.12,
          child: FittedBox(
            child: Text(
              '\$${spentAmount.toStringAsFixed(0)}',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          height: constraints.maxHeight * 0.7,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spentAmountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: constraints.maxHeight * 0.12,
          child: FittedBox(
            child: Text(
              label,
            ),
          ),
        ),
      ]);
    });
  }
}
