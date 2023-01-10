// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double spendingAmount;
  final double spendingFraction;

  const ChartBar(this.dayLabel, this.spendingAmount, this.spendingFraction);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: FittedBox(
              child: Text(
            '\$${spendingAmount.toStringAsFixed(0)}',
          )),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingFraction,
                child: Container(
                    decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
            ],
          ),
        ),
        Text(dayLabel),
      ],
    );
  }
}
