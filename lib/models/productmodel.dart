import 'dart:convert';

class Product {
  final String id;
  final String imageUrl;
  final String title;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl, // Update the key to match the JSON structure
      'title': title,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"] as String,
      imageUrl: map["imageUrl"]
          as String, // Update the key to match the JSON structure
      title: map["title"] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ imageUrl.hashCode ^ title.hashCode;
}
