import '../../auth/domain/entities/signup_response.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupResponse response;
  SignupSuccess(this.response);
}

class SignupFailure extends SignupState {
  final String message;
  SignupFailure(this.message);
}
