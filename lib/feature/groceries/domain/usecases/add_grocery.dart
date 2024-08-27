import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';
import 'package:flutter_assessment/feature/groceries/domain/repository/groceries_repo.dart';

class AddGroceryUsecase {
  final GroceriesRepo groceriesRepo;

  AddGroceryUsecase(this.groceriesRepo);

  Future<Either<Failure, GroceriesEntity>> execute(GroceriesEntity grocery) {
    return groceriesRepo.addGrocery(grocery);
  }
}