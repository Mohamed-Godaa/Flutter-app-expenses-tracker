import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transaction_repository/transaction_repository.dart';

part 'edit_transaction_event.dart';
part 'edit_transaction_state.dart';

class EditTransactionBloc
    extends Bloc<EditTransactionEvent, EditTransactionState> {
  EditTransactionBloc({
    required TransactionRepository transactionRepository,
    Transaction? initialTransaction,
  })  : _transactionRepository = transactionRepository,
        super(EditTransactionState(
          initialTransaction: initialTransaction,
          title: initialTransaction?.title ?? '',
          amount: initialTransaction?.amount ?? 0.0,
          date: initialTransaction?.date,
        )) {
    on<EditTransactionTitleChanged>(_onChanged);
    on<EditTransactionDateChanged>(_onChanged);
    on<EditTransactionAmountChanged>(_onChanged);
    on<EditTransactionSubmitted>(_onSubmitted);
  }

  final TransactionRepository _transactionRepository;

  void _onChanged(
    EditTransactionEvent event,
    Emitter<EditTransactionState> emit,
  ) {
    if (event is EditTransactionTitleChanged) {
      emit(state.copyWith(title: event.title));
    } else if (event is EditTransactionDateChanged) {
      emit(state.copyWith(date: event.date));
    } else if (event is EditTransactionAmountChanged) {
      emit(state.copyWith(amount: event.amount));
    }
  }

  Future<void> _onSubmitted(
    EditTransactionSubmitted event,
    Emitter<EditTransactionState> emit,
  ) async {
    emit(state.copyWith(status: EditTransactionStatus.loading));
    final transaction = (state.initialTransaction ??
            Transaction(title: '', amount: 0.0, date: DateTime.now()))
        .copyWith(
      title: state.title,
      amount: state.amount,
      date: state.date,
    );

    try {
      await _transactionRepository.saveTransaction(transaction);
      emit(state.copyWith(status: EditTransactionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: EditTransactionStatus.failure));
    }
  }
}
