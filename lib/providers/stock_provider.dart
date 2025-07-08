import 'package:flutter/material.dart';
import 'package:refilla/models/item_model.dart';
import 'package:refilla/services/hive_manager.dart';

import '../constants/default_stocks.dart';

class StockProvider extends ChangeNotifier {
  StockProvider() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    checklist = HiveManager.getChecklistItems();

    if (stockList.isEmpty) {
      // Load on first time
      await HiveManager.saveStockItems(defaultStockItems);
      stockList = HiveManager.getStockItems();
    } else {
      stockList = HiveManager.getStockItems();
    }
  }

  List<ItemModel> checklist = [];

  List<ItemModel> stockList = [];

  Future<void> addCheckItem(ItemModel item) async {
    if (!checklist.contains(item)) {
      checklist.add(item);
      notifyListeners();
      await HiveManager.saveCheckItem(item);
    }
  }

  Future<void> removeCheckItem(ItemModel item) async {
    checklist.remove(item);
    notifyListeners();

    await HiveManager.removeFromChecklist(item.name);
  }
}
