import 'package:flutter/material.dart';
import 'package:refilla/constants/app_values.dart';
import 'package:refilla/dialogs/add_stock_dialog.dart';
import 'package:refilla/utils/size_utils.dart';

class AddStockItem extends StatelessWidget {
  const AddStockItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.getHeight(context) * 0.1,
      width: SizeUtils.getHeight(context) * 0.1,
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.defaultRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppValues.defaultRadius),
          onTap: () => _addStock(context),
          child: const Center(
            child: Icon(Icons.add, size: 32, color: Colors.black45),
          ),
        ),
      ),
    );
  }

  void _addStock(BuildContext context) {
    showDialog(context: context, builder: (context) => const AddStockDialog());
  }
}
