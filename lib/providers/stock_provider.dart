import 'package:flutter/material.dart';
import 'package:refilla/constants/default_stocks.dart';
import 'package:refilla/models/item_model.dart';
import 'package:refilla/services/hive_manager.dart';

class StockProvider extends ChangeNotifier {
  StockProvider() {
    _loadItems();
  }

  Future<void> _loadItems() async {
    checklist = HiveManager.getChecklistItems();

    if (HiveManager.isFirstLaunch()) {
      await HiveManager.saveStockItems(defaultStockItems);
      await HiveManager.markFirstLaunchDone();
    }

    stockList = HiveManager.getStockItems();

    notifyListeners();
  }

  List<ItemModel> checklist = [];

  List<ItemModel> stockList = [];

  Future<void> addCheckItem(ItemModel item) async {
    checklist.add(item);
    notifyListeners();
    await HiveManager.saveCheckItem(item);
  }

  Future<void> removeCheckItem(ItemModel item) async {
    checklist.remove(item);
    notifyListeners();

    await HiveManager.removeFromChecklist(item.name);
  }

  Future<int> addStockItem(ItemModel item) async {
    final alreadyExists = stockList.any(
      (i) => i.name.toLowerCase() == item.name.toLowerCase(),
    );

    if (!alreadyExists) {
      stockList.add(item);
      notifyListeners();
      await HiveManager.saveStockItem(item);
      return 1;
    } else {
      return 0;
    }
  }
}
