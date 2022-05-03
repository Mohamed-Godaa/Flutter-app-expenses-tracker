import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTransactionValues.fold(1.0, (previousValue, Map element) {
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
          padding: const EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: e['day'] as String,
                    spentAmount: e['amount'] as double,
                    spentAmountPercentage: (e['amount'] as double) / totalSpent,
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
