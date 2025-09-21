import '../../auth/domain/entities/profile.dart';

abstract class UserEvent {}

class SendOtpEvent extends UserEvent {
  final String phone;
  SendOtpEvent(this.phone);
}

class VerifyOtpEvent extends UserEvent {
  final String phone;
  final String otp;
  VerifyOtpEvent(this.phone, this.otp);
}

class SignupEvent extends UserEvent {
  final Map<String, dynamic> payload;
  SignupEvent(this.payload);
}

class UpdateProfileEvent extends UserEvent {
  final Profile profile;
  UpdateProfileEvent(this.profile);
}

class LoginEvent extends UserEvent {
  final String phone;
  LoginEvent(this.phone);
}

class LogoutEvent extends UserEvent {}

