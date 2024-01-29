
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expense_tracker_2/main.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/transaction.dart';
import 'package:flutter_expense_tracker_2/models/transaction_category.dart';
import 'package:flutter_expense_tracker_2/utils/add_space.dart';
import 'package:flutter_expense_tracker_2/utils/category_icons.dart';
import 'package:flutter_expense_tracker_2/utils/string_formatters.dart';
import 'package:flutter_expense_tracker_2/utils/styles.dart';

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
                          if (amountFieldController.text.isEmpty) {
                            debugPrint('No amount inputted');
                            // TODO message box
                            return;
                          }

                          user.addTransaction(
                            user.selectedAccountIndex, 
                            Transaction(
                              uuid: uuid.v4(), 
                              date: selectedDate, 
                              transactionCategory: selectedAccount.transactionCategories[selectedCategoryIndex], 
                              description: descriptionFieldController.text, 
                              amount: (selectedAccount.transactionCategories[selectedCategoryIndex].type == TransactionCategoryType.income) ? double.parse(amountFieldController.text) : double.parse(amountFieldController.text) * -1
                            )
                          );
                        }, 
                        child: (
                            // selectedDate day AND month AND year are the same as those of the present
                            selectedDate.day == DateTime.now().day
                            && selectedDate.month == DateTime.now().month
                            && selectedDate.year == DateTime.now().year
                          ) 
                          ? const Text('Add new transaction for today') 
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: const Text('Category')),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
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
