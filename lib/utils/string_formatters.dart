import 'package:intl/intl.dart';

String formatAsMoney(double amount) => NumberFormat.simpleCurrency(locale: 'en_US').format(amount);

String formatAsDmy(DateTime dateTime) => DateFormat('dd MMMM yyyy').format(dateTime);