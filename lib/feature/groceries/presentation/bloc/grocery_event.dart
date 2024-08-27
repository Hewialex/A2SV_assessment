// part of 'product_bloc.dart';


import 'package:equatable/equatable.dart';
import 'package:flutter_assessment/feature/groceries/data/models/groceries_model.dart';
import 'package:flutter_assessment/feature/groceries/domain/entities/groceries.dart';

abstract class GroceryEvent extends Equatable {
  const GroceryEvent();

  @override
  List<Object> get props => [];
}

class LoadAllGroceriesEvent extends GroceryEvent {}


// Event to get a single product by ID
class GetSingleGroceryEvent extends GroceryEvent{
  final String id;
  GetSingleGroceryEvent(this.id);
}



// Event to create a new product
class AddGroceryEvent extends GroceryEvent {
  final  GroceriesEntity groceriesEntity;
  AddGroceryEvent(this.groceriesEntity);
}

