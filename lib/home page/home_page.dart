import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_repository/transaction_repository.dart';

import '../transactions_view/transactions_view.dart';

class HomePage extends StatelessWidget {
  // List<Transaction> get _recentTransactions {
  //   return transactions.where((element) {
  //     return element.date.isAfter(
  //       DateTime.now().subtract(
  //         Duration(days: 7),
  //       ),
  //     );
  //   }).toList();
  // }

  // void StartAddNewTransaction(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) {
  //       return NewTransaction(addNewTransaction);
  //     },
  //   );
  // }

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
            Container(
              height: (mediaquery.size.height -
                      mediaquery.padding.top -
                      myAppBar.preferredSize.height) *
                  0.3,
              child: const Placeholder(color: Colors.deepPurple),
            ),
            Container(
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
        onPressed: () {},
      ),
    );
  }
}
