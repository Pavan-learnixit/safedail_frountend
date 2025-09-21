import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/otp_result.dart';
import '../../domain/entities/signup_response.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../datasources/api_service.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    try {
      final response = await apiService.sendOtp(phone);
      if (response.statusCode == 200) return const Right(null);
      return Left(Failure("Failed to send OTP: ${response.statusCode}"));
    } catch (e) {
      Logger.error("Send OTP Error: $e");
      return Left(Failure("Network error: $e"));
    }
  }

  @override
  Future<Either<Failure, OtpResult>> verifyOtp(String phone, String otp) async {
    try {
      final result = await apiService.verifyOtp(phone, otp);
      return Right(result);
    } catch (e) {
      Logger.error("Verify OTP Error: $e");
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SignupResponse>> signup(Map<String, dynamic> payload) async {
    try {
      final response = await apiService.signup(payload);
      if (response.success) {
        return Right(response);
      } else {
        return Left(Failure(response.message));
      }
    } catch (e) {
      return Left(Failure("Signup failed: $e"));
    }
  }


  @override
  Future<Either<Failure, String>> updateProfile(Profile profile) async {
    try {
      final result = await apiService.updateProfile(profile);
      return Right(result['message'] ?? 'Profile updated');
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final result = await apiService.logout();
      final success = result['success'] == true;
      final message = result['message'] ?? 'Logged out';

      if (success) {
        return Right(message);
      } else {
        return Left(Failure(message));
      }
    } catch (e) {
      Logger.error("Logout Error: $e");
      return Left(Failure("Network error: $e"));
    }
  }

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final profile = await apiService.getProfile();
      return Right(profile);
    } catch (e) {
      Logger.error("Get Profile Error: $e");
      return Left(Failure("Failed to fetch profile: $e"));
    }
  }


}
