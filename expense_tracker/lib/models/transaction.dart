import 'package:flutter/foundation.dart';

class Transaction {
  // why final - cant be changed later
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  // using named argument due to lost of variable
  // all properties are required , we add @required - import foundation.dart
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
