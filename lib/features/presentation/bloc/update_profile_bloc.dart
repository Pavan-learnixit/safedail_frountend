import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/usecases/update_profile_usecase.dart';
import 'update_profile_event.dart';
import 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileUseCase useCase;

  UpdateProfileBloc(this.useCase) : super(UpdateProfileInitial()) {
    on<SubmitProfileUpdate>((event, emit) async {
      emit(UpdateProfileLoading());
      final result = await useCase.execute(event.profile);
      result.fold(
            (failure) => emit(UpdateProfileFailure(failure.message)),
            (message) => emit(UpdateProfileSuccess(message)),
      );
    });
  }
}
