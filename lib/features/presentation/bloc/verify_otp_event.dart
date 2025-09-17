abstract class VerifyOtpEvent {}

class VerifyOtpSubmitted extends VerifyOtpEvent {
  final String phone;
  final String otp;
  VerifyOtpSubmitted(this.phone, this.otp);
}

class ResendOtpRequested extends VerifyOtpEvent {
  final String phone;
  ResendOtpRequested(this.phone);
}
