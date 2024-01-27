import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_2/models/account.dart';
import 'package:flutter_expense_tracker_2/models/user.dart';
import 'package:flutter_expense_tracker_2/pages/dashboard_page.dart';
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (value) {
                debugPrint('Selected: $value');
              },
            )
          ),
          Expanded(
            child: Container(
              child: const DashboardPage()
            )
          )
        ],
      )
    );
  }
}