// ignore_for_file: prefer_const_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_storage_transaction_api/local_storage_transaction_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transaction_repository/transaction_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final transactionApi = LocalStorageTransactionApi(
    plugin: await SharedPreferences.getInstance(),
  );
  final transactionRepository =
      TransactionRepository(transactionApi: transactionApi);

  runApp(App(
    transactionRepository: transactionRepository,
  ));
}
