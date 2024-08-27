import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/error/exceptions.dart';
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/core/platform/network_info.dart';
import 'package:flutter_assessment/feature/groceries/data/data_sources/groceries_remote_data_source.dart';
import 'package:flutter_assessment/feature/groceries/data/models/groceries_model.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';
import 'package:flutter_assessment/feature/groceries/domain/repository/groceries_repo.dart';

class GroceriesRepoImpl implements GroceriesRepo {
  final GroceriesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GroceriesRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, GroceriesEntity>> addGrocery(GroceriesEntity grocery) async {
    if (await networkInfo.isConnected) {
      // Instead of sending the grocery to an API, we'll simply return it
      // as a success response, simulating adding it to the cart.
      try {
        // Simulate adding grocery to cart
        return Right(grocery);
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }

  @override
  Future<Either<Failure, GroceriesEntity>> getGroceryById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final groceryEntityOrFailure = await remoteDataSource.getGroceryById(id);
        return groceryEntityOrFailure;
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<GroceriesEntity>>> getAllGroceries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAllGroceries();
        return result;
      } on ServerException {
        return Left(ServerFailure('An error has occurred'));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      return Left(ConnectionFailure('No Internet connection'));
    }
  }
}
Future<List<GroceriesModel>> fetchGroceries() async {
  final apiUrl = "https://g5-flutter-learning-path-be.onrender.com/api/v1/groceries";
  
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => GroceriesModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
