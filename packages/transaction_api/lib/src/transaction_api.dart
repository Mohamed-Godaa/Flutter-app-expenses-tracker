import 'package:transaction_api/transaction_api.dart';

/// {@template transaction_api}
/// The interface and models for an api to access transactions
/// {@endtemplate}
abstract class TransactionApi {
  /// {@macro transaction_api}
  const TransactionApi();

  ///Provides a [Stream] of all the [Transaction]s.
  Stream<List<Transaction>> getTransactions();

  /// Saves a [transaction].
  ///
  /// If a [transaction] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Transaction transaction);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [TransactionNotFoundException]
  /// error is thrown.
  Future<void> deleteTodo(String id);
}

class TransactionNotFoundException implements Exception {
  @override
  String toString() {
    return "Couldn't find any transactions with the given Id";
  }
}
