import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double? price;

  @HiveField(2)
  final int? quantity;

  @HiveField(3)
  final String? unit;

  @HiveField(4)
  final String? image;

  ItemModel({
    required this.name,
    this.quantity,
    this.price,
    this.unit,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'unit': unit,
    'image': image,
  };
}
