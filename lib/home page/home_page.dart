import 'package:flutter/material.dart';

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
    final AppBar myAppBar = AppBar(title: Text('Personal Expenses'), actions: [
      IconButton(
        icon: Icon(Icons.add),
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
              child: const Placeholder(color: Colors.purple),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
