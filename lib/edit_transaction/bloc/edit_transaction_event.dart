part of 'edit_transaction_bloc.dart';

abstract class EditTransactionEvent extends Equatable {
  const EditTransactionEvent();

  @override
  List<Object> get props => [];
}

class EditTransactionTitleChanged extends EditTransactionEvent {
  final String title;

  const EditTransactionTitleChanged(this.title);

  @override
  List<Object> get props => [title];
}

class EditTransactionAmountChanged extends EditTransactionEvent {
  final double amount;

  const EditTransactionAmountChanged(this.amount);

  @override
  List<Object> get props => [amount];
}

class EditTransactionDateChanged extends EditTransactionEvent {
  final DateTime date;

  const EditTransactionDateChanged(this.date);

  @override
  List<Object> get props => [date];
}

class EditTransactionSubmitted extends EditTransactionEvent {
  const EditTransactionSubmitted();
}
