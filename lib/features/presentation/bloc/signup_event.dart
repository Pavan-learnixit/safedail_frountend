abstract class SignupEvent {}

class SignupSendOtpPressed extends SignupEvent {
  final Map<String, dynamic> payload;
  SignupSendOtpPressed(this.payload);
}
