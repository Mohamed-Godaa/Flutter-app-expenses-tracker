part of 'edit_transaction_bloc.dart';

enum EditTransactionStatus { initial, success, loading, failure }

class EditTransactionState extends Equatable {
  const EditTransactionState({
    this.status = EditTransactionStatus.initial,
    this.initialTransaction,
    this.title = '',
    this.amount = 0.0,
    this.date,
  });

  final EditTransactionStatus status;
  final Transaction? initialTransaction;
  final String title;
  final double amount;
  final DateTime? date;

  bool get isNewTransaction => initialTransaction == null;

  EditTransactionState copyWith({
    EditTransactionStatus? status,
    Transaction? initialTransaction,
    String? title,
    double? amount,
    DateTime? date,
  }) {
    return EditTransactionState(
      status: status ?? this.status,
      initialTransaction: initialTransaction ?? this.initialTransaction,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [status, initialTransaction, title, amount, date];
}
