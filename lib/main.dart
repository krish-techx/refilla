import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:refilla/pages/check_list_page.dart';
import 'package:refilla/services/hive_manager.dart';

import 'providers/stock_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveManager.init();

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
