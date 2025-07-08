import 'package:flutter/material.dart';

class StockProvider extends ChangeNotifier {
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
