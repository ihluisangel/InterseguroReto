import 'package:dartz/dartz.dart';
import 'package:interseguroapp/domain/models/auth/user.dart';
import 'package:interseguroapp/domain/repositories/auth_repository.dart';

import '../../commons/failure.dart';

class GetUser {
  final AuthRepository authRepository;

  GetUser({required this.authRepository});

  Future<Either<Failure, User>> execute() async {
    return authRepository.getUser();
  }
}
