import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/main.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';
import 'package:flutter_expense_tracker_2/models/user.dart';
import 'package:flutter_expense_tracker_2/pages/transactions_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var selectedAccount = user.accounts[user.selectedAccountIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account count: ${user.accounts.length}'),
        Text('Selected account: ${selectedAccount.name}'),
        Text('UUID: ${selectedAccount.uuid}'),
        Text('Transaction count: ${selectedAccount.transactions.length}'),
        Text('Transaction category count: ${selectedAccount.transactionCategories.length}'),
        ElevatedButton(
          onPressed: () {
            user.addAccount(Account(uuid: uuid.v4(), name: 'Account ${user.accounts.length + 1}', transactions: [], transactionCategories: []));
            user.selectedAccountIndex += 1;
          },
          child: const Text('Add default account')
        ),
        ElevatedButton(
          onPressed: () {
            user.addTransaction(
              user.selectedAccountIndex, 
              Transaction(
                uuid: uuid.v4(), 
                date: DateTime.now(), 
                transactionCategory: TransactionCategory(
                  uuid: uuid.v4(), 
                  iconData: Icons.attach_money.toString(), 
                  name: 'Example transaction', 
                  type: TransactionCategoryType.expense
                ), 
                description: 'This is an example transaction', 
                amount: 100
              )
            );
           },
          child: const Text('Add example transaction'),
        ),
        Expanded(child: TransactionsListView(selectedAccount: selectedAccount)),
      ],
    );
  }
}
