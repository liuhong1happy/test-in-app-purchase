import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import 'logic/dash_counter.dart';
import 'logic/dash_purchases.dart';
import 'logic/dash_upgrades.dart';
import 'pages/home_page.dart';

// Gives the option to override in tests.
class IAPConnection {
  static InAppPurchase? _instance;
  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash Clicker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Dash Clicker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

typedef PageBuilder = Widget Function();

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashCounter>(create: (_) => DashCounter()),
        ChangeNotifierProvider<DashUpgrades>(
          create: (context) => DashUpgrades(
            context.read<DashCounter>()
          )
        ),
        ChangeNotifierProvider<DashPurchases>(
          create: (context) => DashPurchases(
            context.read<DashCounter>()
          ),
          lazy: false,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const HomePage()
      ),
    );
  }
}
