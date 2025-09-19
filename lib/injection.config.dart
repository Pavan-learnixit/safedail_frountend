// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:truecaller_clone/features/auth/data/datasources/api_service.dart'
    as _i1055;
import 'package:truecaller_clone/features/auth/data/repositories/auth_repository_impl.dart'
    as _i0;
import 'package:truecaller_clone/features/auth/domain/repositories/auth_repository.dart'
    as _i579;
import 'package:truecaller_clone/features/auth/domain/usecases/auth_usecases.dart'
    as _i385;
import 'package:truecaller_clone/features/auth/domain/usecases/profile_usecases.dart'
    as _i1037;
import 'package:truecaller_clone/features/presentation/bloc/user_bloc.dart'
    as _i252;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1055.ApiService>(() => _i1055.ApiService());
    gh.lazySingleton<_i579.AuthRepository>(
        () => _i0.AuthRepositoryImpl(gh<_i1055.ApiService>()));
    gh.factory<_i1037.ProfileUseCases>(
        () => _i1037.ProfileUseCases(gh<_i579.AuthRepository>()));
    gh.lazySingleton<_i385.AuthUseCases>(
        () => _i385.AuthUseCases(gh<_i579.AuthRepository>()));
    gh.factory<_i252.UserBloc>(() => _i252.UserBloc(
          authUseCases: gh<_i385.AuthUseCases>(),
          profileUseCases: gh<_i1037.ProfileUseCases>(),
        ));
    return this;
  }
}
