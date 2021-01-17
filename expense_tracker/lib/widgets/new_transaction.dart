// This file is for lifting state up
// Final instances can be accessed by transaction list
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class >>> NewTransaction
class NewTransaction extends StatefulWidget {
  // two instances for storing title and amount of item
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  // selectedDate is not final because user will choose it later
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    // private function for adding data to list
    void _submitData() {
      var title = titleController.text;
      var amount = double.parse(amountController.text);
      if (amount == null) amount = 0;
      if (title.isEmpty || amount <= 0 || _selectedDate == null) return;
      widget._addNewTransaction(title, amount, _selectedDate);
      Navigator.of(context).pop();
    }

    // method for date picker
    void _presentDatePicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now())
          .then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return Card(
        margin: EdgeInsets.zero,
        elevation: 7,
        color: Colors.grey[300],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // for button to be shifted left , else others have wi
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 21),
                // textField - title
                child: Material(
                  borderRadius: BorderRadius.circular(23),
                  elevation: 9,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(vertical: 7),
                // textfield - amount
                child: Material(
                  elevation: 9,
                  borderRadius: BorderRadius.circular(23),
                  child: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: amountController,
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(color: Colors.blueGrey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            borderSide: BorderSide(color: Colors.transparent))),
                    onSubmitted: (_) => _submitData(),
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    // expanded for choosing available space
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date Chosen !'
                          : 'Date : ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      child: Text('Choose Date',
                          style: TextStyle(
                            color: Colors.red[200],
                          )),
                      onPressed: () {
                        _presentDatePicker();
                      },
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                onPressed: _submitData,
              )
            ],
          ),
        ));
  }
}
