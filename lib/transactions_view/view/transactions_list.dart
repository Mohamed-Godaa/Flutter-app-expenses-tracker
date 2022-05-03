import 'package:expenses_tracker/transactions_view/transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //Error Listener
        BlocListener<TransactionViewBloc, TransactionViewState>(
          listener: (context, state) {
            if (state.status == TransactionViewStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Error occured'),
                  ),
                );
            }
          },
          listenWhen: (previous, current) => previous.status != current.status,
        ),
        BlocListener<TransactionViewBloc, TransactionViewState>(
          //Transaction deleted listener
          listenWhen: (previous, current) =>
              previous.lastDeletedTransaction !=
                  current.lastDeletedTransaction &&
              current.lastDeletedTransaction != null,
          listener: (context, state) {
            final deletedTransactionTitle = state.lastDeletedTransaction;
            final messenger = ScaffoldMessenger.of(context);

            messenger
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('deleted ${deletedTransactionTitle!.title} !'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => context
                        .read<TransactionViewBloc>()
                        .add(const TransactionViewUndoDeletionRequested()),
                  ),
                ),
              );
          },
        ),
      ],
      child: BlocBuilder<TransactionViewBloc, TransactionViewState>(
        builder: (context, state) {
          if (state.transactions.isEmpty) {
            //Loading
            if (state.status == TransactionViewStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == TransactionViewStatus.success) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            }
          }
          final transactions = state.transactions;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$ ${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<TransactionViewBloc>().add(
                              TransactionViewTransactionDeleted(
                                  transactions[index]),
                            );
                      },
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
