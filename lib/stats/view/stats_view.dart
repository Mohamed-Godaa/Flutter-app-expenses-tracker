import 'package:expenses_tracker/stats/bloc/transaction_stats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_repository/transaction_repository.dart';

import './chart_bar.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionStatsBloc(
        transactionRepository: context.read<TransactionRepository>(),
      )..add(const StatsSubscriptionRequested()),
      child: StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<TransactionStatsBloc>().state;
    final groupedTransactionValues = state.groupedTransactionValues;
    final totalSpent = state.totalSpent;
    return Container(
      padding: const EdgeInsets.only(
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
