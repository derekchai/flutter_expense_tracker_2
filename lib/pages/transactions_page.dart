
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/user.dart';
import 'package:flutter_expense_tracker_2/utils/add_space.dart';
import 'package:flutter_expense_tracker_2/utils/styles.dart';
import 'package:flutter_expense_tracker_2/widgets/new_transaction_form.dart';
import 'package:flutter_expense_tracker_2/widgets/transactions_list_view.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    var selectedAccount = user.accounts[user.selectedAccountIndex];
    
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 800, child: NewTransactionForm(selectedAccount: selectedAccount,)),
          addVerticalSpace(40),
          const Text('Transactions', style: headerStyle),
          addVerticalSpace(20),
          Expanded(child: SizedBox(width: 800, child: TransactionsListView(selectedAccount: selectedAccount))),
        ],
      ),
    );
  }
}
