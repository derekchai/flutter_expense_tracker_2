import 'package:flutter/material.dart';

enum TransactionCategoryType {
  income,
  savings,
  expense
}

class TransactionCategory extends ChangeNotifier {
  TransactionCategory({
    required this.uuid,
    required this.iconData,
    required this.name,
    required this.type
  });

  final String uuid;
  String iconData;
  String name;
  TransactionCategoryType type;

  
}