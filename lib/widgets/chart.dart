import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final WeekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == WeekDay.day &&
            recentTransactions[i].date.month == WeekDay.month &&
            recentTransactions[i].date.year == WeekDay.year)
          totalSum += recentTransactions[i].amount;
      }
      return {
        'day': DateFormat.E().format(WeekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTransactionValues.fold(1.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 5,
        right: 8,
        left: 8,
      ),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: e['day'],
                    spentAmount: e['amount'],
                    spentAmountPercentage: (e['amount'] as double) / totalSpent,
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
