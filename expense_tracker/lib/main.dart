import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme data
      theme: ThemeData(
          primaryColor: Color(0xFF3A4664),
          accentColor: Colors.pink[100],
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'Oxygen', fontSize: 18, color: Colors.grey[900])),
          // button theme
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF3A4664),
            textTheme: ButtonTextTheme.accent,
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(secondary: Colors.pink[50]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
          )),
      title: 'Expense Tracker',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//Widget Chart function

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _title = 'Personal Expense';
  final List<Transaction> _userTransaction = [
    //   Transaction(
    //       id: 'a1', title: 'Reebok shoes', amount: 6000, date: DateTime.now()),
    //   Transaction(
    //       id: 'a2', title: 'Sweat Shirt', amount: 8000, date: DateTime.now()),
  ];
  // Function >>> containing past week data
  List<Transaction> get _recentTransaction {
    // passing item to the anonymous function as tx
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // Function >>> adding new transaction
  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    // creating Transaction object with provdied instances
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );
    // updating the list using setState
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // Function >>> deleting the Transaction
  void _deleteTransaction(String id) {
    // remove where contains function that iterates over instances of list
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  // Functio >>> showing sheet for new transaction
  void _startaddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: TextStyle(color: Colors.red[50])),
        backgroundColor: Color(0xFF3A4664),
        elevation: 0.0,
        actions: [
          IconButton(
            color: Colors.red[50],
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () => _startaddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: (Column(
          children: [
            // Chart Card
            Chart(_recentTransaction),
            // Transaction list card - stateless widget
            TransactionList(_userTransaction, _deleteTransaction),
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 7,
        backgroundColor: Color(0xFFEAA0A2),
        onPressed: () => _startaddNewTransaction(context),
      ),
    );
  }
}
