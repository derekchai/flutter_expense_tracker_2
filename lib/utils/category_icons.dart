import 'package:flutter/material.dart';

const List<IconData> categoryIcons = [
  Icons.attach_money,
  Icons.money,
  Icons.fastfood
];

IconData? categoryIconDataFromString(String string) {
  for (IconData icon in categoryIcons) {
    if (icon.toString() == string) {
      return icon;
    }
  }
  return null;
}