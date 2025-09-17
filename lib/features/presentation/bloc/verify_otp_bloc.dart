import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/entities/otp_result.dart';
import '../../auth/domain/usecases/send_otp_usecase.dart';
import '../../auth/domain/usecases/verify_otp_usecase.dart';
import '../../presentation/pages/verify_otp_screen.dart';
import 'verify_otp_event.dart';
import 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final SendOtpUseCase sendOtpUseCase;

  VerifyOtpBloc(this.verifyOtpUseCase, this.sendOtpUseCase) : super(VerifyOtpInitial()) {
    on<VerifyOtpSubmitted>((event, emit) async {
      emit(VerifyOtpLoading());
      final result = await verifyOtpUseCase.execute(event.phone, event.otp);
      result.fold(
            (failure) => emit(VerifyOtpFailure(failure.message)),
            (otpResult) {
          switch (otpResult) {
            case OtpResult.success:
              emit(VerifyOtpSuccess());
              break;
            case OtpResult.invalid:
              emit(VerifyOtpFailure("Invalid OTP"));
              break;
            case OtpResult.expired:
              emit(VerifyOtpFailure("OTP expired"));
              break;
            case OtpResult.serverError:
              emit(VerifyOtpFailure("Server error"));
              break;
            case OtpResult.networkError:
              emit(VerifyOtpFailure("Network error"));
              break;
          }
        },
      );
    });

    on<ResendOtpRequested>((event, emit) async {
      final result = await sendOtpUseCase.execute(event.phone);
      result.fold(
            (failure) => emit(ResendOtpFailure(failure.message)),
            (_) => emit(ResendOtpSuccess()),
      );
    });
  }
}
