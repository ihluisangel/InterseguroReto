import 'package:dartz/dartz.dart';

import '../../commons/failure.dart';
import '../repositories/auth_repository.dart';

class OnLogout {
  final AuthRepository authRepository;

  OnLogout({required this.authRepository});

  Future<Either<Failure, bool>> execute() async {
    return authRepository.logut();
  }
}
