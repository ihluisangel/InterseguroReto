import 'package:dartz/dartz.dart';

import '../../commons/failure.dart';
import '../repositories/auth_repository.dart';

class IsRemember {
  final AuthRepository authRepository;

  IsRemember({required this.authRepository});

  Future<Either<Failure, bool>> execute() async {
    return authRepository.isRemember();
  }
}
