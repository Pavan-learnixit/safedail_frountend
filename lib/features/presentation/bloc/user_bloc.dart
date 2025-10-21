import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:truecaller_clone/features/presentation/bloc/user_events.dart';
import 'package:truecaller_clone/features/presentation/bloc/user_states.dart';
import '../../auth/domain/usecases/auth_usecases.dart';
import '../../auth/domain/usecases/profile_usecases.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUseCases authUseCases;
  final ProfileUseCases profileUseCases;

  UserBloc({
    required this.authUseCases,
    required this.profileUseCases,
  }) : super(UserInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<SignupEvent>(_onSignup);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RequestVerificationEvent>(_onRequestVerification);

  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.sendOtp(event.phone);
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (_) => emit(OtpSent()),
    );
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.verifyOtp(event.phone, event.otp);
    result.fold(
            (failure) => emit(UserError(failure.message)),
          (otpResult) => add(LoginEvent(event.phone)), // then dispatch login

    );
  }

  Future<void> _onSignup(SignupEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.signup(event.payload);
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (response) => emit(SignupSuccess(response)),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.updateProfile(event.profile);
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (message) => emit(ProfileUpdated(message)),
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.getProfile(); // or login(event.phone) if you have one
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (profile) => emit(LoginSuccess(profile)),
    );
  }

  Future<void> _onRequestVerification(
      RequestVerificationEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());
    final result = await profileUseCases.requestVerification(
      idProof: event.idProof,
      note: event.note,
    );
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (_) => emit(VerificationSubmittedState()),
    );
  }


  Future<void> _onLogout(LogoutEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await authUseCases.logout();
    result.fold(
          (failure) => emit(UserError(failure.message)),
          (message) => emit(LogoutSuccess(message)),
    );
  }
}
