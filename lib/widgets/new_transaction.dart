// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();
  DateTime? _datePicked;

  void submitData() {
    var theTitle = titleControler.text;
    var theAmount = double.parse(amountControler.text);

    if (theTitle.isNotEmpty &&
        theAmount > 0 &&
        theAmount != null &&
        _datePicked != null) {
      widget.addNewTransaction(
          titleControler.text, double.parse(amountControler.text), _datePicked);
    } else
      return;
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
        (value) => value == null ? () {} : setState(() => _datePicked = value));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              onSubmitted: (_) => submitData(),
              controller: titleControler,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              controller: amountControler,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_datePicked == null
                      ? 'No date chosen'
                      : '${DateFormat.yMd().format(_datePicked as DateTime)}'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text('Choose date'),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text(
                'Add transaction',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button?.color,
            )
          ]),
        ),
      ),
    );
  }
}
