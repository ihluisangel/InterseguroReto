import 'package:dartz/dartz.dart';
import 'package:interseguroapp/domain/models/auth/user.dart';
import 'package:interseguroapp/domain/repositories/auth_repository.dart';

import '../../commons/failure.dart';

class OnLogin {
  final AuthRepository authRepository;

  OnLogin({required this.authRepository});

  Future<Either<Failure, User>> execute(
      {required String username,
      required String password,
      required bool isRemember}) async {
    return authRepository.login(
        username: username, password: password, isRemember: isRemember);
  }
}
