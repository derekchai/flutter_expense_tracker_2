import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';

class Account {
  Account({
    required this.uuid,
    required this.name,
    required this.transactions,
    required this.transactionCategories
  });

  final String uuid;
  String name;
  List<Transaction> transactions;
  List<TransactionCategory> transactionCategories; 
}