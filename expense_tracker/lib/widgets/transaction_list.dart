// This class is Stateless - called in stateful class widget .
// user_transaction triggers built method and new changes will be reflected
// as new data has been passed through constructor
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

// Widget Transaction Card list function
Widget transactionList(
    List<Transaction> _userTransaction, Function deleteTransaction) {
  return Container(
    height: 500,
    child: _userTransaction.isEmpty
        ? Column(
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset(
                  'asset/Images/no_transaction.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text('You have not added any Transaction ',
                  style: TextStyle(color: Colors.grey, fontSize: 12))
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF3A4664),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                                '\$${_userTransaction[index].amount.round()}',
                                style: TextStyle(color: Colors.pink[50])),
                          ),
                        )),
                    title: Text(
                      _userTransaction[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat.yMMMMd()
                        .format(_userTransaction[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.red[200],
                      onPressed: () =>
                          deleteTransaction(_userTransaction[index].id),
                    )),
              );
            },
            itemCount: _userTransaction.length,
          ),
  );
}

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;
  TransactionList(this.userTransaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactionList(userTransaction, deleteTransaction);
  }
}
