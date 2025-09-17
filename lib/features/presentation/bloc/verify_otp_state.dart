abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {}

class VerifyOtpFailure extends VerifyOtpState {
  final String message;
  VerifyOtpFailure(this.message);
}

class ResendOtpSuccess extends VerifyOtpState {}

class ResendOtpFailure extends VerifyOtpState {
  final String message;
  ResendOtpFailure(this.message);
}
