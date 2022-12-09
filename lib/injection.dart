import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:interseguroapp/data/datasources/auth_local_datasource.dart';
import 'package:interseguroapp/data/datasources/auth_remote_datasource.dart';
import 'package:interseguroapp/data/repositories/auth_repository_impl.dart';
import 'package:interseguroapp/domain/repositories/auth_repository.dart';
import 'package:interseguroapp/domain/usecases/get_user.dart';
import 'package:interseguroapp/domain/usecases/is_remember.dart';
import 'package:interseguroapp/domain/usecases/on_login.dart';
import 'package:interseguroapp/domain/usecases/on_logout.dart';
import 'package:interseguroapp/presentation/provider/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider

  locator.registerFactory(
    () => AuthBloc(
        onLogin: locator(),
        getUser: locator(),
        isRememberCase: locator(),
        onLogoutCase: locator()),
  );

  // use case
  locator.registerLazySingleton(() => OnLogin(authRepository: locator()));
  locator.registerLazySingleton(() => GetUser(authRepository: locator()));
  locator.registerLazySingleton(() => IsRemember(authRepository: locator()));
  locator.registerLazySingleton(() => OnLogout(authRepository: locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
      authLocalDatasource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl());

  // helper

  // external
  locator.registerLazySingleton(() => http.Client());
}
