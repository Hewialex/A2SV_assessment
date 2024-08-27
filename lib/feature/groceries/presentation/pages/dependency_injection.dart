import 'package:flutter_assessment/feature/groceries/data/repositories/grocery_repo_impl.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/add_grocery.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/get_groceries.dart';
import 'package:flutter_assessment/feature/groceries/domain/usecases/get_grocery.dart';
import 'package:flutter_assessment/feature/groceries/domain/repository/groceries_repo.dart';
import 'package:flutter_assessment/feature/groceries/presentation/bloc/grocery_bloc.dart';
import 'package:flutter_assessment/feature/groceries/data/data_sources/groceries_remote_data_source.dart';
import 'package:flutter_assessment/core/platform/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Register external dependencies
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: getIt()));

  // Register data sources
  getIt.registerLazySingleton<GroceriesRemoteDataSource>(
    () => GroceriesRemoteDataSourceImpl(client: getIt()),
  );

  // Register repositories
  getIt.registerLazySingleton<GroceriesRepo>(
    () => GroceriesRepoImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Register use cases
  getIt.registerLazySingleton<AddGroceryUsecase>(
    () => AddGroceryUsecase(getIt()),
  );
  getIt.registerLazySingleton<GetGroceriesUsecase>(
    () => GetGroceriesUsecase(getIt()),
  );
  getIt.registerLazySingleton<GetGroceryUsecase>(
    () => GetGroceryUsecase(getIt()),
  );

  // Register Bloc
  getIt.registerFactory<GroceryBloc>(
    () => GroceryBloc(
      addGroceryUsecase: getIt(),
      getGroceriesUsecase: getIt(),
      getGroceryUsecase: getIt(),
    ),
  );
}
