import 'package:bloc/bloc.dart';
import 'package:flutter_assessment/core/error/failure.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/add_grocery.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/get_groceries.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/get_grocery.dart';
import 'package:flutter_assessment/feature/groceries/presentation/bloc/grocery_event.dart';
import 'package:flutter_assessment/feature/groceries/presentation/bloc/grocery_state.dart';

class GroceryBloc extends Bloc<GroceryEvent, GroceryState> {
  final AddGroceryUsecase addGroceryUsecase;
  final GetGroceriesUsecase getGroceriesUsecase;
  final GetGroceryUsecase getGroceryUsecase;

  GroceryBloc({
    required this.addGroceryUsecase,
    required this.getGroceriesUsecase,
    required this.getGroceryUsecase,
  }) : super(GroceryInitial()) {
    on<LoadAllGroceriesEvent>((event, emit) async {
      emit(GroceryLoading());
      final result = await getGroceriesUsecase.execute();
      result.fold(
        (failure) => emit(GroceryError(_mapFailureToMessage(failure))),
        (groceries) => emit(GroceryLoadedAll(groceries)),
      );
    });

    on<GetSingleGroceryEvent>((event, emit) async {
      emit(GroceryLoading());
      final result = await getGroceryUsecase.execute(event.id);
      result.fold(
        (failure) => emit(GroceryError(_mapFailureToMessage(failure))),
        (grocery) => emit(SingleGroceryLoaded(grocery)),
      );
    });

    on<AddGroceryEvent>((event, emit) async {
      emit(GroceryLoading());
      final result = await addGroceryUsecase.execute(event.groceriesEntity);
      result.fold(
        (failure) => emit(GroceryError(_mapFailureToMessage(failure))),
        (_) => emit(GroceryOperationSuccess()),
      );
    });

    
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
