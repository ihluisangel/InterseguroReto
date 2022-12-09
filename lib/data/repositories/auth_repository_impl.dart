import 'dart:io';

import 'package:interseguroapp/data/datasources/auth_local_datasource.dart';
import 'package:interseguroapp/data/datasources/auth_remote_datasource.dart';
import 'package:interseguroapp/domain/models/auth/user.dart';

import '../../commons/exception.dart';
import '../../commons/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl(
      {required this.authLocalDatasource, required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> login(
      {required String username,
      required String password,
      required bool isRemember}) async {
    try {
      final result = await authRemoteDataSource.login(
          username: username, password: password);
      if (result.code == 0) {
        if (isRemember) {
          await authLocalDatasource.saveUser(result.body!);
        }
        return Right(result.body!);
      }
      return Left(ServerFailure(result.message));
    } on ServerException {
      return const Left(ServerFailure('Failed server'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    var user = await authLocalDatasource.getUser();
    if (user != null) {
      return Right(user);
    } else {
      return const Left(DatabaseFailure("Missing user"));
    }
  }

  @override
  Future<Either<Failure, bool>> isRemember() async {
    var user = await authLocalDatasource.getUser();
    if (user != null) {
      return const Right(true);
    } else {
      return const Right(false);
    }
  }

  @override
  Future<Either<Failure, bool>> logut() async {
    var user = await authLocalDatasource.removeUser();
    if (user) {
      return const Right(true);
    } else {
      return const Right(false);
    }
  }
}
