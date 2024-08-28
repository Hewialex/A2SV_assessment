import 'package:equatable/equatable.dart';

class GroceriesEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final String price;
  final double discount;
  final String description;

  GroceriesEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        rating,
        price,
        discount,
        description,
      ];
}
