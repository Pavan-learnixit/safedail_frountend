import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/signup_response.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<Either<Failure, SignupResponse>> execute(Map<String, dynamic> payload) {
    return repository.signup(payload);
  }
}
