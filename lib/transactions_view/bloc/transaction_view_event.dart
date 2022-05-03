part of 'transaction_view_bloc.dart';

@immutable
abstract class TransactionViewEvent extends Equatable {
  const TransactionViewEvent();

  @override
  List<Object?> get props => [];
}

class TransactionViewSubscriptionRequested extends TransactionViewEvent {
  const TransactionViewSubscriptionRequested();
}

class TransactionViewTransactionDeleted extends TransactionViewEvent {
  const TransactionViewTransactionDeleted(this.transaction);

  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}

class TransactionViewUndoDeletionRequested extends TransactionViewEvent {
  const TransactionViewUndoDeletionRequested();
}
