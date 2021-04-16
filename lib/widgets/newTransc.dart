import 'dart:io';

import 'package:expenses/widgets/adapt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NewTransac extends StatefulWidget {
  final Function addTran;

  NewTransac(this.addTran);

  @override
  _NewTransacState createState() => _NewTransacState();
}

class _NewTransacState extends State<NewTransac> {
  DateTime _selecdDate;

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _send_Data() {
    final enteredItem = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (_amountController.text.isEmpty) {
      return;
    }
    if (enteredItem.isEmpty || enteredAmount <= 0 || _selecdDate == null) {
      return;
    }
    widget.addTran(enteredItem, enteredAmount, _selecdDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selecdDate = selectedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 9,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              //  CupertinoTextField(placeholder: ,),
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _send_Data(),
                decoration: InputDecoration(labelText: 'Item'),
              ),
              TextField(
                controller: _amountController,
                onSubmitted: (_) => _send_Data(),
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              Container(
                height: 85,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(_selecdDate == null
                          ? 'Missing Date...'
                          : 'Selected Date: ${DateFormat.yMMMd().format(_selecdDate)}'),
                    ),
                    Adapt('Select', _datePicker),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blueGrey[100],
                onPressed: () {
                  _send_Data();
                },
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
