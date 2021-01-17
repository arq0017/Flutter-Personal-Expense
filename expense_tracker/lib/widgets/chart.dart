import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './char_bar.dart';

extension IsSameDate on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class Chart extends StatelessWidget {
  // list of past week transactions
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  // list for individual bar
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // getting the day
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmount = 0;
      // iterate through list for total transaciton done on weekDay
      for (var tx in recentTransaction) {
        if (weekDay.isSameDate(tx.date)) totalAmount += tx.amount;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  get totalSpending {
    // why grouped transaction Value list - because we will make use of key - amount as Map
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((val) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: val['day'],
                  spendingAmount: val['amount'],
                  spendingPercentage: totalSpending == 0
                      ? 0
                      : (val['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
      elevation: 6,
      color: Color(0xFFEAA0A2),
    );
  }
}
