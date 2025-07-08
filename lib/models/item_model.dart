class ItemModel {
  final String name;
  final double price;
  final int quantity;
  final String unit;
  final String image;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.unit,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'unit': unit,
    'image': image,
  };
}
