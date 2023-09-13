import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class product {
  final String name;
  final String image;
  final int price;
  final String description;
  late int quantity;
  product({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  factory product.fromMap(Map<String, dynamic> map) {
    return product(
      name: (map["name"] ?? '') as String,
      image: (map["image"] ?? '') as String,
      price: (map["price"] ?? '') as int,
      description: (map["description"] ?? '') as String,
      quantity: (map["quantity"] ?? '') as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory product.fromJson(String source) =>
      product.fromMap(json.decode(source) as Map<String, dynamic>);
}
