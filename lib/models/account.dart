import 'package:collection/collection.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';

class Account {
  Account({
    required this.uuid,
    required this.name,
    required this.transactions,
    required this.transactionCategories,
    this.openingBalance = 0
  });

  final String uuid;
  String name;
  List<Transaction> transactions;
  List<TransactionCategory> transactionCategories; 
  double openingBalance;

  double get closingBalance {
    if (transactions.isEmpty) {
      return 0;
    }
    return transactions.map<double>((transaction) => transaction.amount).sum;
  }
}