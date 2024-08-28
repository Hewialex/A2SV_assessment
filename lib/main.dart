
import 'package:flutter/material.dart';
import 'package:flutter_assessment/feature/groceries/presentation/bloc/grocery_bloc.dart';
import 'package:flutter_assessment/feature/groceries/presentation/bloc/grocery_event.dart';
import 'package:flutter_assessment/feature/groceries/presentation/pages/dependency_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_assessment/feature/groceries/presentation/pages/splash_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  init(); // Initialize DI setup
  runApp(MyApp());
}

final sl = GetIt.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GroceryBloc>(
            create: (context) => sl<GroceryBloc>()..add(LoadAllGroceriesEvent()),
          ),
          BlocProvider<GroceryBloc>(
            create: (context) => sl<GroceryBloc>(),
          ),
        ],
        child: SplashScreen(), // Start with the splash screen
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
