import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';
import 'package:flutter_assessment/feature/groceries/data/models/groceries_model.dart';

abstract class GroceriesRemoteDataSource {
  Future<Either<Failure, List<GroceriesEntity>>> getAllGroceries();
  Future<Either<Failure, GroceriesEntity>> getGroceryById(String id);
  Future<Either<Failure, GroceriesEntity>> addGrocery(GroceriesEntity grocery);
}

class GroceriesRemoteDataSourceImpl extends GroceriesRemoteDataSource {
  final http.Client client;

  GroceriesRemoteDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, List<GroceriesEntity>>> getAllGroceries() async {
    const apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries";
    try {
      final response = await client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];
          final List<GroceriesEntity> groceries = data
              .map((json) => GroceriesModel.fromJson(json).toEntity())
              .toList();
          return Right(groceries);
        } else {
          return Left(ServerFailure('No data found'));
        }
      } else {
        return Left(ServerFailure('Server error'));
      }
    } on SocketException {
      return Left(NetworkFailure('Network failure occurred.'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, GroceriesEntity>> getGroceryById(String id) async {
    final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries/$id";
    try {
      final response = await client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final groceryModel = GroceriesModel.fromJson(responseBody);
        return Right(groceryModel.toEntity());
      } else {
        return Left(ServerFailure('Failed to retrieve grocery'));
      }
    } on SocketException {
      return Left(NetworkFailure('Network failure occurred.'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, GroceriesEntity>> addGrocery(GroceriesEntity grocery) async {
    // Simulate adding the grocery to a cart by adding it to a local list or state
    try {
      // Assuming you have a cart service or manager to handle this
      // cartService.addGrocery(grocery);
      return Right(grocery);
    } catch (e) {
      return Left(ServerFailure('Failed to add grocery to cart.'));
    }
  }
}
