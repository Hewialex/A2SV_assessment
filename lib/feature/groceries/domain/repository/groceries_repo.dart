import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';

abstract class GroceriesRepo {
  Future<Either<Failure, List<GroceriesEntity>>> getAllGroceries();
  Future<Either<Failure, GroceriesEntity>> getGroceryById(String id);
  Future<Either<Failure, GroceriesEntity>> addGrocery(GroceriesEntity grocery);
}