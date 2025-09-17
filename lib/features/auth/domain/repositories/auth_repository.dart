import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/profile.dart';
import '../entities/otp_result.dart';
import '../entities/signup_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendOtp(String phone);
  Future<Either<Failure, OtpResult>> verifyOtp(String phone, String otp);
  Future<Either<Failure, SignupResponse>> signup(Map<String, dynamic> payload);
  Future<Either<Failure, Profile>> getProfile();
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, String>> updateProfile(Profile profile);

}
