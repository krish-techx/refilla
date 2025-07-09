import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refilla/models/item_model.dart';
import 'package:refilla/widgets/app_text_field.dart';

import '../providers/stock_provider.dart';

class AddStockDialog extends StatefulWidget {
  const AddStockDialog({super.key});

  @override
  State<AddStockDialog> createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Stock Item'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Name
              AppTextField(
                controller: _nameController,
                hint: 'Name',
                isRequired: true,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          onPressed: () => _addItem(context),
          child: const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _addItem(BuildContext context) async {
    final navigator = Navigator.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    final focusScope = FocusScope.of(context);

    if (_formKey.currentState!.validate()) {
      final newItem = ItemModel(name: _nameController.text.trim());

      context
          .read<StockProvider>()
          .addStockItem(newItem)
          .then((value) {
            if (value == 1) {
              navigator.pop();
            } else {
              focusScope.requestFocus(FocusNode());
              scaffold.showSnackBar(
                SnackBar(content: Text('Item Already Exist')),
              );
            }
          })
          .onError((error, stackTrace) {
            log('Error while adding stock item');
          });
    }
  }
}
