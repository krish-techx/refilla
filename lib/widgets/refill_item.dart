import 'package:flutter/material.dart';
import 'package:refilla/constants/app_values.dart';
import 'package:refilla/models/item_model.dart';

class RefillItem extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;

  const RefillItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.smallPadding),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppValues.smallPadding),
          child: Padding(
            padding: const EdgeInsets.all(AppValues.smallPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppValues.smallPadding),
                const Text('0.0', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
