abstract class LoginEvent {}

class SendOtpPressed extends LoginEvent {
  final String phoneNumber;
  SendOtpPressed(this.phoneNumber);
}
