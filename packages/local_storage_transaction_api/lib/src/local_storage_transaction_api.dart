// ignore_for_file: require_trailing_commas

import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transaction_api/transaction_api.dart';

/// {@template local_storage_transaction_api}
/// An implementation of the TransactionApi that uses local_storage.
/// {@endtemplate}
class LocalStorageTransactionApi extends TransactionApi {
  /// {@macro local_storage_transaction_api}
  LocalStorageTransactionApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _transactionsStraemController =
      BehaviorSubject<List<Transaction>>.seeded(const []);

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  ///Transactions Key
  static const transactionsCollectionKey = '__transaction_collection_key__';

  void _init() {
    final transactionsJson = _getValue(transactionsCollectionKey);
    if (transactionsJson != null) {
      final transactions = List<Map>.from(json.decode(transactionsJson) as List)
          .map((jsonMap) =>
              Transaction.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _transactionsStraemController.add(transactions);
    } else {
      _transactionsStraemController.add(const []);
    }
  }

  @override
  Stream<List<Transaction>> getTransactions() =>
      _transactionsStraemController.asBroadcastStream();

  @override
  Future<void> deleteTodo(String id) {
    final transactions = [..._transactionsStraemController.value];
    final index = transactions.indexWhere((e) => e.id == id);
    if (index == -1) {
      throw TransactionNotFoundException();
    } else {
      transactions.removeAt(index);
    }

    _transactionsStraemController.add(transactions);
    return _setValue(transactionsCollectionKey, json.encode(transactions));
  }

  @override
  Future<void> saveTodo(Transaction transaction) {
    final transactions = [..._transactionsStraemController.value];
    final index = transactions.indexWhere((e) => e.id == transaction.id);
    if (index >= 0) {
      transactions[index] = transaction;
    } else {
      transactions.add(transaction);
    }

    _transactionsStraemController.add(transactions);
    return _setValue(transactionsCollectionKey, json.encode(transactions));
  }
}
