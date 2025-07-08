import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refilla/pages/check_list_page.dart';

import 'providers/stock_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockProvider(),
      builder:
          (context, child) => MaterialApp(
            title: 'Refilla',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            ),
            home: const CheckListPage(),
          ),
    );
  }
}
