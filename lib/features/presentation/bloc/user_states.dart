import '../../auth/domain/entities/otp_result.dart';
import '../../auth/domain/entities/profile.dart';
import '../../auth/domain/entities/signup_response.dart';

abstract class UserState {}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class VerificationSubmittedState extends UserState {}
class VerificationSubmittingState extends UserState {}
class OtpSent extends UserState {}

class OtpVerified extends UserState {
  final OtpResult result;
  OtpVerified(this.result);
}

class SignupSuccess extends UserState {
  final SignupResponse response;
  SignupSuccess(this.response);
}

class ProfileUpdated extends UserState {
  final String message;
  ProfileUpdated(this.message);
}


class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class LoginSuccess extends UserState {
  final Profile profile;
  LoginSuccess(this.profile);
}

class LogoutSuccess extends UserState {
  final String message;
  LogoutSuccess(this.message);
}




