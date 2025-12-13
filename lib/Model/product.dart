import 'package:d12m12y2025/Model/rating.dart';

class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      image: json['image'] ?? "",
      rating: json['rating'] != null
          ? Rating.fromJson(json['rating'])
          : Rating(),
    );
  }
}
