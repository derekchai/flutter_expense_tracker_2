import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';

class User extends ChangeNotifier {
  User({
    required this.accounts,
    required this.selectedAccountIndex
  });

  List<Account> accounts;
  int selectedAccountIndex;

  void addAccount(Account account) {
    accounts.add(account);
    notifyListeners();
  }

  void removeAccountAt(int index) {
    accounts.removeAt(index);
    notifyListeners();
  }

  void removeAccount(Account account) {
    accounts.remove(account);
    notifyListeners();
  }

  void addTransaction(int targetAccountIndex, Transaction transaction) {
    accounts[targetAccountIndex].transactions.add(transaction);
    notifyListeners();
  }
}