import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refilla/constants/app_values.dart';
import 'package:refilla/providers/stock_provider.dart';
import 'package:refilla/utils/size_utils.dart';
import 'package:refilla/widgets/add_stock_item.dart';
import 'package:refilla/widgets/refill_item.dart';
import 'package:refilla/widgets/stock_item.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({super.key});

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  @override
  Widget build(BuildContext context) {
    final stock = context.watch<StockProvider>();
    final checklist = stock.checklist;
    final stockList =
        stock.stockList
            .where((i) => !checklist.any((c) => c.name == i.name))
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Checklist')),
      body: Stack(
        children: [
          // Item list
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.smallPadding * 2,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                    checklist.isEmpty
                        ? Center(
                          child: Text(
                            'All items are up-to date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        : GridView.builder(
                          itemCount: checklist.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                          itemBuilder: (context, index) {
                            final item = checklist[index];

                            return RefillItem(
                              item: item,
                              onTap: () => stock.removeCheckItem(item),
                            );
                          },
                        ),
              ),
            ),
          ),

          // Item area
          Positioned(
            left: AppValues.smallPadding,
            right: AppValues.smallPadding,
            bottom: AppValues.smallPadding,
            child: Container(
              height: SizeUtils.getHeight(context) * 0.1,
              width: SizeUtils.getWidth(context),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(AppValues.defaultRadius),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: stockList.length + 1,
                itemBuilder: (context, index) {
                  if (index == stockList.length) return AddStockItem();

                  final item = stockList[index];
                  return StockItem(
                    item: item,
                    onTap: () => stock.addCheckItem(item),
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
