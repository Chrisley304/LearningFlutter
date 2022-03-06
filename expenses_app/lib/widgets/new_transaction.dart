import 'dart:io';

import 'package:expenses_app/widgets/adaptiveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isNotEmpty && enteredAmount > 0 && _selectedDate != null) {
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021, 12, 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Title',
                      controller: titleController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      onSubmitted: (_) => _submitData(),
                      // onChanged: (value) => titleInput = value,
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      controller: amountController,
                      onSubmitted: (_) => _submitData(),
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _submitData(),
                      // onChanged: (value) => amountInput = value,
                    ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate != null
                          ? "Date: ${DateFormat.yMMMMd().format(_selectedDate!)}"
                          : "No Date Chosen!"),
                    ),
                    AdaptiveFlatButton('Choose date', _presentDatePicker)
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _submitData,
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                    )
                  : FlatButton(
                      onPressed: _submitData,
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
