import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';

class Transaction extends ChangeNotifier {
  Transaction({
    required this.uuid,
    required this.date,
    required this.transactionCategory,
    required this.description,
    required this.amount
  });

  final String uuid;
  DateTime date;
  TransactionCategory transactionCategory;
  String description;
  double amount;
}