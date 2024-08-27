import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';

abstract class GroceryState extends Equatable {
  const GroceryState();

  @override
  List<Object> get props => [];
}

// Represents the initial state before any data is loaded
class GroceryInitial extends GroceryState {}

// Indicates that the app is currently fetching data
class GroceryLoading extends GroceryState {}

// Represents the state where all groceries are successfully loaded from the repository
class GroceryLoadedAll extends GroceryState {
  final List<GroceriesEntity> groceries;

  const GroceryLoadedAll(this.groceries);

  @override
  List<Object> get props => [groceries];
}

// Represents the state where a single grocery item is successfully retrieved
class SingleGroceryLoaded extends GroceryState {
  final GroceriesEntity grocery;

  const SingleGroceryLoaded(this.grocery);

  @override
  List<Object> get props => [grocery];
}

// Indicates that an error has occurred during data retrieval or processing
class GroceryError extends GroceryState {
  final String message;

  const GroceryError(this.message);

  @override
  List<Object> get props => [message];
}

// Represents the state where a grocery operation (add, update, delete) was successful
class GroceryOperationSuccess extends GroceryState {}
