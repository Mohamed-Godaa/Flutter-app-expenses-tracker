import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_repository/transaction_repository.dart';

import '../edit_transaction/bloc/edit_transaction_bloc.dart';
import '../edit_transaction/view/view.dart';
import '../stats/view/view.dart';
import '../transactions_view/transactions_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final AppBar myAppBar =
        AppBar(title: const Text('Personal Expenses'), actions: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    ]);
    return Scaffold(
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (mediaquery.size.height -
                      mediaquery.padding.top -
                      myAppBar.preferredSize.height) *
                  0.3,
              child: const StatsChart(),
            ),
            SizedBox(
              height: (mediaquery.size.height -
                      mediaquery.padding.top -
                      myAppBar.preferredSize.height) *
                  0.7,
              child: BlocProvider(
                create: (context) => TransactionViewBloc(
                    transactionRepository:
                        context.read<TransactionRepository>())
                  ..add(
                    const TransactionViewSubscriptionRequested(),
                  ),
                child: const TransactionsList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return BlocProvider(
                create: (context) => EditTransactionBloc(
                    transactionRepository:
                        context.read<TransactionRepository>()),
                child: const EditTransaction(),
              );
            },
          );
        },
      ),
    );
  }
}
