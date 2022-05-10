part of 'transaction_stats_bloc.dart';

abstract class TransactionStatsEvent extends Equatable {
  const TransactionStatsEvent();

  @override
  List<Object> get props => [];
}

class StatsSubscriptionRequested extends TransactionStatsEvent {
  const StatsSubscriptionRequested();
}
