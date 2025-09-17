
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;
  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, String>> execute(Profile profile) {
    return repository.updateProfile(profile);
  }
}
