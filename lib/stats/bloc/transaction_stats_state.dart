part of 'transaction_stats_bloc.dart';

enum TransactionStatsStatus { initial, success, failure, loading }

class TransactionStatsState extends Equatable {
  const TransactionStatsState({
    this.status = TransactionStatsStatus.initial,
    this.transactions = const [],
  });

  final TransactionStatsStatus status;
  final List<Transaction> transactions;

  List<Transaction> get recentTransactions {
    return transactions.where((element) {
      return element.date!.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date?.day == weekDay.day &&
            recentTransactions[i].date?.month == weekDay.month &&
            recentTransactions[i].date?.year == weekDay.year) {
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

  TransactionStatsState copyWith({
    TransactionStatsStatus? status,
    List<Transaction>? transactions,
  }) {
    return TransactionStatsState(
      status: status ?? this.status,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object> get props => [
        status,
        transactions,
        totalSpent,
        recentTransactions,
        groupedTransactionValues,
      ];
}
