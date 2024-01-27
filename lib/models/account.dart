import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';

class Account extends ChangeNotifier {
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

  void changeNameTo(String name) {
    name = name;
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  void removeTransactionAt(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }

  void removeTransaction(String uuid) {
    for (var transaction in transactions) {
      if (transaction.uuid == uuid) {
        transactions.remove(transaction);
        break;
      }
    }
    notifyListeners();
  }

  void addTransactionCategory(TransactionCategory transactionCategory) {
    transactionCategories.add(transactionCategory);
    notifyListeners();
  }

  void removeTransactionCategoryAt(int index) {
    transactionCategories.removeAt(index);
    notifyListeners();
  }
}