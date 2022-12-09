import 'package:interseguroapp/domain/models/auth/user.dart';

import '../../commons/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
      {required String username,
      required String password,
      required bool isRemember});
  Future<Either<Failure, bool>> isRemember();
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, bool>> logut();
}
