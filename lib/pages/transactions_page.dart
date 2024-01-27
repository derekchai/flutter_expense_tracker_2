
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_tracker_2/main.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/user.dart';
import 'package:flutter_expense_tracker_2/utils/add_space.dart';
import 'package:flutter_expense_tracker_2/utils/category_icons.dart';
import 'package:flutter_expense_tracker_2/utils/string_formatters.dart';
import 'package:flutter_expense_tracker_2/utils/styles.dart';
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

class NewTransactionForm extends StatelessWidget {
  const NewTransactionForm({
    required this.selectedAccount,
    super.key,
  });

  final Account selectedAccount;

  @override
  Widget build(BuildContext context) {
    final amountFieldController = TextEditingController();
    final descriptionFieldController = TextEditingController();
    int selectedCategoryIndex = 0;
    DateTime selectedDate = DateTime.now();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('\$ ', style: bigNumberSignStyle,),
                  Expanded(
                    child: TextField(
                      controller: amountFieldController,
                      keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                      style: bigNumberStyle,
                      decoration: const InputDecoration.collapsed(hintText: '0'),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpace(15),
              TextField(
                controller: descriptionFieldController,
                decoration: const InputDecoration.collapsed(hintText: 'Description'),
              ),
              addVerticalSpace(15),
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          var result = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100)); 
                          if (result != null) {
                            selectedDate = result;
                          }
                          debugPrint('Date selected: ${selectedDate.toString()}');
                          setState(() {});
                        }, 
                        icon: const Icon(Icons.calendar_month)
                      ), 
                      ElevatedButton(
                        onPressed: () {
                          user.addTransaction(
                            user.selectedAccountIndex, 
                            Transaction(
                              uuid: uuid.v4(), 
                              date: selectedDate, 
                              transactionCategory: selectedAccount.transactionCategories[selectedCategoryIndex], 
                              description: descriptionFieldController.text, 
                              amount: double.parse(amountFieldController.text)
                            )
                          );
                        }, 
                        child: (
                            // selectedDate day AND month AND year are the same as those of the present
                            selectedDate.day == DateTime.now().day
                            && selectedDate.month == DateTime.now().month
                            && selectedDate.year == DateTime.now().year
                          ) 
                          ? const Text('Add for today') 
                          : Text('Add for ${formatAsDmy(selectedDate)}')
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
        StatefulBuilder(
          builder: (context, setState) {
          return Column(
            children: [
              const Text('Category'),
              SizedBox(
                width: 170,
                height: 100,
                child: ListView.builder(
                  itemCount: selectedAccount.transactionCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: ElevatedButton.icon(
                        style: (index == selectedCategoryIndex) ? ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary) : ElevatedButton.styleFrom(),
                        onPressed: () {
                          setState(() {selectedCategoryIndex = index;});
                        },
                        icon: Icon(categoryIconDataFromString(selectedAccount.transactionCategories[index].iconData)),
                        label: Text(selectedAccount.transactionCategories[index].name),
                      ),
                    );
                  },
                ),
              ),
            ],
          );}
        )
      ],
    );
  }
}

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