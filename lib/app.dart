import 'package:expenses_tracker/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_repository/transaction_repository.dart';

import 'home_page/home.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.transactionRepository,
  }) : super(key: key);

  final TransactionRepository transactionRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: transactionRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      title: 'expenses tracker',
      home: HomePage(),
    );
  }
}
