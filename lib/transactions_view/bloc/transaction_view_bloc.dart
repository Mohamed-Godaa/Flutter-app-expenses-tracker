import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:transaction_repository/transaction_repository.dart';

part 'transaction_view_event.dart';
part 'transaction_view_state.dart';

class TransactionViewBloc
    extends Bloc<TransactionViewEvent, TransactionViewState> {
  TransactionViewBloc({
    required TransactionRepository transactionRepository,
  })  : _transactionRepository = transactionRepository,
        super(const TransactionViewState()) {
    on<TransactionViewSubscriptionRequested>(_onSubscriptionRequested);
    on<TransactionViewTransactionDeleted>(_onTransactionDeleted);
    on<TransactionViewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final TransactionRepository _transactionRepository;

  Future<void> _onSubscriptionRequested(
    TransactionViewSubscriptionRequested event,
    Emitter<TransactionViewState> emit,
  ) async {
    emit(state.copyWith(status: () => TransactionViewStatus.loading));

    await emit.forEach<List<Transaction>>(
        _transactionRepository.getTransactions(),
        onData: (transactions) => state.copyWith(
              status: () => TransactionViewStatus.success,
              transactions: () => transactions,
            ),
        onError: (_, __) => state.copyWith(
              status: () => TransactionViewStatus.failure,
            ));
  }

  Future<void> _onTransactionDeleted(
    TransactionViewTransactionDeleted event,
    Emitter<TransactionViewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTransaction: () => event.transaction));
    await _transactionRepository.deleteTransaction(event.transaction.id!);
  }

  Future<void> _onUndoDeletionRequested(
    TransactionViewUndoDeletionRequested event,
    Emitter<TransactionViewState> emit,
  ) async {
    assert(state.lastDeletedTransaction != null,
        'last deleted transaction cannot be null');

    final transaction = state.lastDeletedTransaction!;
    emit(state.copyWith(lastDeletedTransaction: () => null));
    await _transactionRepository.saveTransaction(transaction);
  }
}
