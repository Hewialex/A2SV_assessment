import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';

class GroceriesModel extends GroceriesEntity {
  // Constructor
  GroceriesModel({
    required String id,
    required String title,
    required String imageUrl,
    required double rating,
    required double price,
    required double discount,
    required String description,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          rating: rating,
          price: price,
          discount: discount,
          description: description,
        );

  /// Factory constructor to create a [GroceriesModel] from a JSON object
  factory GroceriesModel.fromJson(Map<String, dynamic> json) {
    return GroceriesModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
    );
  }

  /// Method to convert the [GroceriesModel] to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'description': description,
    };
  }

  /// Convert from GroceriesEntity to GroceriesModel
  static GroceriesModel fromEntity(GroceriesEntity grocery) {
    return GroceriesModel(
      id: grocery.id,
      title: grocery.title,
      imageUrl: grocery.imageUrl,
      rating: grocery.rating,
      price: grocery.price,
      discount: grocery.discount,
      description: grocery.description,
    );
  }

  /// Convert from GroceriesModel to GroceriesEntity
  GroceriesEntity toEntity() {
    return GroceriesEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      discount: discount,
      description: description,
    );
  }
}
