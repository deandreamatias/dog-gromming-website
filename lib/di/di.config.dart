// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dog_gromming_website/data/datasources/local/default_local_datasource.dart'
    as _i7;
import 'package:dog_gromming_website/data/datasources/local/local_data_source.dart'
    as _i6;
import 'package:dog_gromming_website/data/datasources/remote/default_remote_datasource.dart'
    as _i9;
import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart'
    as _i8;
import 'package:dog_gromming_website/data/services/api_service.dart' as _i5;
import 'package:dog_gromming_website/di/di.dart' as _i11;
import 'package:dog_gromming_website/domain/use_cases/send_email_use_case.dart'
    as _i10;
import 'package:dog_gromming_website/env/env.dart' as _i3;
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DiModule();
    final apiServiceModule = _$ApiServiceModule();
    gh.singleton<_i3.Env>(() => diModule.env);
    gh.singleton<_i4.MainNavigator>(() => diModule.navigator);
    gh.lazySingleton<_i5.ApiService>(() => apiServiceModule.httpClient);
    gh.factory<_i6.LocalDataSource>(() => _i7.DefaultLocalDataSource());
    gh.factory<_i8.RemoteDatasource>(() => _i9.DefaultRemoteDatasource(
          gh<_i5.ApiService>(),
          gh<_i3.Env>(),
        ));
    gh.factory<_i10.SendEmailUseCase>(
        () => _i10.SendEmailUseCase(gh<_i8.RemoteDatasource>()));
    return this;
  }
}

class _$DiModule extends _i11.DiModule {}

class _$ApiServiceModule extends _i5.ApiServiceModule {}
