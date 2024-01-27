import 'package:intl/intl.dart';

String formatAsMoney(double amount) {
  return NumberFormat.simpleCurrency(locale: 'en_US').format(amount);
}