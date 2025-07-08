import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StockManager(),
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

class StockManager extends ChangeNotifier {
  final List<String> checklist = [];
  final List<String> itemMaster = [
    'Mango',
    'Tomato',
    'Orange',
    'Onion',
    'Coconut',
  ];

  void addItemToChecklist(String item) {
    if (!checklist.contains(item)) {
      checklist.add(item);
      notifyListeners();
    }
  }

  removeFromChecklist(String item) {
    checklist.remove(item);
    notifyListeners();
  }
}

class CheckListPage extends StatefulWidget {
  const CheckListPage({super.key});

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  @override
  Widget build(BuildContext context) {
    final stock = context.watch<StockManager>();
    final checklist = stock.checklist;
    final itemMaster =
        stock.itemMaster.where((i) => !checklist.contains(i)).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Checklist')),
      body: Stack(
        children: [
          // Item list
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: checklist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final item = checklist[index];

                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onLongPress: () => stock.removeFromChecklist(item),

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    '0.0',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Item area
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: itemMaster.length,
                itemBuilder: (context, index) {
                  final item = itemMaster[index];

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // color: Colors.teal.shade100,
                      child: InkWell(
                        onTap: () => stock.addItemToChecklist(item),
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
