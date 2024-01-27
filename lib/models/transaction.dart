// ignore_for_file: unnecessary_this

import 'package:flutter_expense_tracker_2/models/transaction_category.dart';
import 'package:intl/intl.dart';

class Transaction {
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

  String dmyFormattedDate() {
    return DateFormat('dd MMMM yyyy').format(this.date);
  }
}