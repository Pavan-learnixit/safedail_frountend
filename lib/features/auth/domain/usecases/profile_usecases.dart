import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/auth_repository.dart';
@injectable
class ProfileUseCases {
  final AuthRepository repository;

  ProfileUseCases(this.repository);

  Future<Either<Failure, String>> updateProfile(Profile profile) {
    return repository.updateProfile(profile);
  }

  Future<Either<Failure, void>> requestVerification({
    required File idProof,
    required String note,
  }) {
    return repository.requestVerification(idProof: idProof, note: note);
  }
}
