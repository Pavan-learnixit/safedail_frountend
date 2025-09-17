
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/usecases/signup_usecase.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUseCase signupUseCase;

  SignupBloc(this.signupUseCase) : super(SignupInitial()) {
    on<SignupSendOtpPressed>((event, emit) async {
      emit(SignupLoading());
      final result = await signupUseCase.execute(event.payload);
      result.fold(
            (failure) => emit(SignupFailure(failure.message)),
            (response) => emit(SignupSuccess(response)),
      );
    });
  }
}
