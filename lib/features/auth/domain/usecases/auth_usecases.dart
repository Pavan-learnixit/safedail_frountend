import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../entities/profile.dart';
import '../entities/otp_result.dart';
import '../entities/signup_response.dart';
@lazySingleton
class AuthUseCases {
  final AuthRepository repository;

  AuthUseCases(this.repository);

  Future<Either<Failure, void>> sendOtp(String phone) {
    return repository.sendOtp(phone);
  }

  Future<Either<Failure, OtpResult>> verifyOtp(String phone, String otp) {
    return repository.verifyOtp(phone, otp);
  }

  Future<Either<Failure, SignupResponse>> signup(Map<String, dynamic> payload) {
    return repository.signup(payload);
  }

  Future<Either<Failure, String>> updateProfile(Profile profile) {
    return repository.updateProfile(profile);
  }

  Future<Either<Failure, Profile>> getProfile() {
    return repository.getProfile();
  }

  Future<Either<Failure, String>> logout() {
    return repository.logout();
  }

}


