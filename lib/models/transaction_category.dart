// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

enum TransactionCategoryType {
  income,
  savings,
  expense
}

class TransactionCategory {
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

  Color color() {
    switch (this.type) {
      case TransactionCategoryType.expense:
        return Colors.red;
      case TransactionCategoryType.income:
        return Colors.green;
      case TransactionCategoryType.savings:
        return Colors.amber;
    }
  }

}