part of 'transaction_view_bloc.dart';

enum TransactionViewStatus { initial, loading, success, failure }

@immutable
class TransactionViewState extends Equatable {
  const TransactionViewState({
    this.status = TransactionViewStatus.initial,
    this.transactions = const [],
    this.lastDeletedTransaction,
  });

  final TransactionViewStatus status;
  final List<Transaction> transactions;
  final Transaction? lastDeletedTransaction;

  TransactionViewState copyWith({
    TransactionViewStatus Function()? status,
    List<Transaction> Function()? transactions,
    Transaction? Function()? lastDeletedTransaction,
  }) {
    return TransactionViewState(
      status: status != null ? status() : this.status,
      transactions: transactions != null ? transactions() : this.transactions,
      lastDeletedTransaction: lastDeletedTransaction != null
          ? lastDeletedTransaction()
          : this.lastDeletedTransaction,
    );
  }

  @override
  List<Object?> get props => [status, transactions, lastDeletedTransaction];
}
