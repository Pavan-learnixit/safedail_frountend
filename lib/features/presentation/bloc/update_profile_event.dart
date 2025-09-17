import '../../auth/domain/entities/profile.dart';

abstract class UpdateProfileEvent {}

class SubmitProfileUpdate extends UpdateProfileEvent {
  final Profile profile;
  SubmitProfileUpdate(this.profile);
}
