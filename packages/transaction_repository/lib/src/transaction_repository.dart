import 'package:transaction_api/transaction_api.dart';

/// {@template transaction_repository}
/// A repository that handles transaction requests.
/// {@endtemplate}
class TransactionRepository {
  /// {@macro transaction_repository}
  const TransactionRepository({required TransactionApi transactionApi})
      : _transactionApi = transactionApi;

  final TransactionApi _transactionApi;

  ///Returns a [Stream] with all the [Transaction]s.
  Stream<List<Transaction>> getTransactions() =>
      _transactionApi.getTransactions();

  /// Saves a [transaction].
  ///
  /// If a [transaction] with the same id already exists, it will be replaced.
  Future<void> saveTodo(Transaction transaction) =>
      _transactionApi.saveTodo(transaction);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [TransactionNotFoundException]
  /// error is thrown.
  Future<void> deleteTodo(String id) => _transactionApi.deleteTodo(id);
}
