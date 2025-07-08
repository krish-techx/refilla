import 'package:flutter/material.dart';
import 'package:refilla/constants/app_values.dart';
import 'package:refilla/utils/size_utils.dart';

class StockItem extends StatelessWidget {
  final String item;
  final VoidCallback? onTap;

  const StockItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.getHeight(context) * 0.1,
      width: SizeUtils.getHeight(context) * 0.1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.smallPadding),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppValues.smallPadding),
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
  }
}
