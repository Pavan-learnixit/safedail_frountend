import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/usecases/send_otp_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SendOtpUseCase sendOtpUseCase;

  LoginBloc(this.sendOtpUseCase) : super(LoginInitial()) {
    on<SendOtpPressed>((event, emit) async {
      emit(LoginLoading());
      final result = await sendOtpUseCase.execute(event.phoneNumber);
      result.fold(
            (failure) => emit(LoginFailure(failure.message)),
            (_) => emit(OtpSentSuccess()),
      );
    });
  }
}
