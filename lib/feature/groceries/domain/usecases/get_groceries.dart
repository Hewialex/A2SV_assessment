import 'package:dartz/dartz.dart';
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';
import 'package:flutter_assessment/feature/groceries/domain/repository/groceries_repo.dart';

class GetGroceriesUsecase {
  final GroceriesRepo groceriesRepo;

  GetGroceriesUsecase(this.groceriesRepo);

  Future<Either<Failure, List<GroceriesEntity>>> execute() {
    return groceriesRepo.getAllGroceries();
  }
}
