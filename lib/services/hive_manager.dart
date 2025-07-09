import 'package:hive/hive.dart';
import 'package:refilla/models/item_model.dart';

class HiveManager {
  static const String _stockBoxName = 'stockBox';
  static const String _checklistBoxName = 'checklistBox';
  static const String _metaBoxName = 'appMetaBox';

  static late Box<ItemModel> _stockBox;
  static late Box<ItemModel> _checklistBox;

  static Future<void> init() async {
    Hive.registerAdapter(ItemModelAdapter());
    _stockBox = await Hive.openBox<ItemModel>(_stockBoxName);
    _checklistBox = await Hive.openBox<ItemModel>(_checklistBoxName);
    await Hive.openBox(_metaBoxName);
  }

  // region ##### Meta operations #####
  static Future<void> markFirstLaunchDone() async {
    final box = Hive.box(_metaBoxName);
    await box.put('isFirstLaunch', false);
  }

  static bool isFirstLaunch() {
    final box = Hive.box(_metaBoxName);
    return box.get('isFirstLaunch', defaultValue: true);
  }

  // endregion

  // region ##### Stock operations #####
  static List<ItemModel> getStockItems() => _stockBox.values.toList();

  static Future<void> saveStockItems(List<ItemModel> items) async {
    await _stockBox.clear();
    for (var item in items) {
      await _stockBox.add(item);
    }
  }

  static Future<void> saveStockItem(ItemModel item) async {
    await _stockBox.add(item);
  }

  // endregion

  // region ##### Checklist operations #####
  static List<ItemModel> getChecklistItems() => _checklistBox.values.toList();

  static Future<void> saveCheckItem(ItemModel item) async {
    await _checklistBox.add(item);
  }

  static Future<void> removeFromChecklist(String itemName) async {
    final key = _checklistBox.keys.firstWhere(
      (k) => _checklistBox.get(k)!.name == itemName,
      orElse: () => null,
    );
    if (key != null) await _checklistBox.delete(key);
  }

  // endregion

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }

  static Future<void> deleteBox(String boxName) async {
    await Hive.box(boxName).close();
    await Hive.deleteBoxFromDisk(boxName);
  }
}
