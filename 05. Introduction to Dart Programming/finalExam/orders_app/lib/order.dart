// lib/order.dart
class Order {
  final String item;
  final String itemName;
  final num price;
  final String currency;
  final int quantity;
  const Order({
    required this.item,
    required this.itemName,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        item: json['Item'] as String,
        itemName: json['ItemName'] as String,
        price: json['Price'] as num,
        currency: json['Currency'] as String,
        quantity: json['Quantity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'Item': item,
        'ItemName': itemName,
        'Price': price,
        'Currency': currency,
        'Quantity': quantity,
      };
}
