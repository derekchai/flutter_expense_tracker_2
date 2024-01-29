
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/main.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/utils/category_icons.dart';
import 'package:flutter_expense_tracker_2/utils/string_formatters.dart';
import 'package:flutter_expense_tracker_2/utils/styles.dart';

class TransactionsListView extends StatelessWidget {
  const TransactionsListView({
    super.key,
    required this.selectedAccount,
  });

  final Account selectedAccount;

  @override
  Widget build(BuildContext context) {
    if (selectedAccount.transactions.isEmpty) {
      return const Text('Add some transactions and they will appear here!');
    } else {
      return ListView.builder(
      itemCount: selectedAccount.transactions.length,
      itemBuilder: (context, index) {
        var transaction = selectedAccount.transactions[index];
        return Card(
          child: ListTile(
            leading: Tooltip(
              message: transaction.transactionCategory.name,
              child: Icon(
                categoryIconDataFromString(transaction.transactionCategory.iconData),
                color: transaction.transactionCategory.color(),
              )
            ),
            title: Text(transaction.description),
            subtitle: Text('${transaction.dmyFormattedDate()} — ${transaction.uuid}'),
            trailing: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(formatAsMoney(transaction.amount), style: subtitleStyle14),
                  ),
                  IconButton(
                    onPressed: () {
                      user.removeTransactionAt(user.selectedAccountIndex, index);
                    }, 
                    icon: const Icon(Icons.remove),
                    hoverColor: Colors.red.withOpacity(0.4),
                    highlightColor: Colors.red,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
    }
  }
}