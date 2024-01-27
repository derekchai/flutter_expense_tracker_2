import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/user.dart';
import 'package:flutter_expense_tracker_2/pages/dashboard_page.dart';
import 'package:flutter_expense_tracker_2/pages/transactions_page.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final Account defaultAccount = Account(uuid: uuid.v4(), name: "Default Account", transactions: [], transactionCategories: []);

User user = User(accounts: [defaultAccount], selectedAccountIndex: 0);

void main() {
  // TODO: JSON deserialize accounts list from file.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create:(context) => user,
      child: MaterialApp(
        title: 'Flutter Demo',
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = const DashboardPage();
        break;
      case 1: 
        page = const TransactionsPage();
        break;
      default:
        throw UnimplementedError('No widget for selectedIndex $selectedIndex');
    }


    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.attach_money),
                  label: Text('Transactions'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: page,
            )
          )
        ],
      )
    );
  }
}