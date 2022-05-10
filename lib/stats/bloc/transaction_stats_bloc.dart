import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:transaction_repository/transaction_repository.dart';

part 'transaction_stats_event.dart';
part 'transaction_stats_state.dart';

class TransactionStatsBloc
    extends Bloc<TransactionStatsEvent, TransactionStatsState> {
  TransactionStatsBloc({
    required TransactionRepository transactionRepository,
  })  : _transactionRepository = transactionRepository,
        super(const TransactionStatsState()) {
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final TransactionRepository _transactionRepository;

  Future<void> _onSubscriptionRequested(
    TransactionStatsEvent event,
    Emitter<TransactionStatsState> emit,
  ) async {
    emit(state.copyWith(status: TransactionStatsStatus.loading));

    emit.forEach<List<Transaction>>(_transactionRepository.getTransactions(),
        onData: (transactions) => state.copyWith(
              status: TransactionStatsStatus.success,
              transactions: transactions,
            ),
        onError: (_, __) =>
            state.copyWith(status: TransactionStatsStatus.failure));
  }
}
