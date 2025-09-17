import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../presentation/pages/verify_otp_screen.dart';
import '../entities/otp_result.dart';
import '../repositories/auth_repository.dart';
class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, OtpResult>> execute(String phone, String otp) {
    return repository.verifyOtp(phone, otp);
  }
}
