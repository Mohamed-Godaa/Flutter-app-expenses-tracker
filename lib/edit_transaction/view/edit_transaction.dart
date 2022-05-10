// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:transaction_api/transaction_api.dart';
import 'package:transaction_repository/transaction_repository.dart';
import 'package:expenses_tracker/edit_transaction/edit_transaction.dart';

class EditTransaction extends StatelessWidget {
  const EditTransaction({
    Key? key,
    this.initialTransaction,
  }) : super(key: key);

  final Transaction? initialTransaction;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditTransactionBloc>();
    final status = bloc.state.status;
    final isNewTransaction = bloc.state.isNewTransaction;
    final state = context.watch<EditTransactionBloc>().state;
    final date = state.date ?? initialTransaction?.date;

    return BlocBuilder<EditTransactionBloc, EditTransactionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Card(
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    isNewTransaction ? 'Add Transaction' : 'Edit Tramsaction',
                  ),
                ),
                TextFormField(
                  initialValue: state.initialTransaction?.title ?? '',
                  onChanged: (title) =>
                      bloc.add(EditTransactionTitleChanged(title)),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextFormField(
                  initialValue:
                      state.initialTransaction?.amount.toString() ?? '',
                  onChanged: (amount) => bloc
                      .add(EditTransactionAmountChanged(double.parse(amount))),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date == null
                          ? 'Choose Date'
                          : DateFormat.yMd().format(date)),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            value == null
                                ? () {}
                                : bloc.add(EditTransactionDateChanged(value));
                          });
                        },
                        child: const Text('Choose date'),
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: status.isLoadingOrSuccess
                      ? null
                      : () {
                          bloc.add(const EditTransactionSubmitted());
                          Navigator.of(context).pop();
                        },
                  child: status.isLoadingOrSuccess
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          isNewTransaction
                              ? 'Add transaction'
                              : 'Update transaction',
                        ),
                  color: status.isLoadingOrSuccess
                      ? Theme.of(context).primaryColor.withOpacity(0.5)
                      : Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button?.color,
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
