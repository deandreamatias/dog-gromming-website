// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dog_gromming_website/data/datasources/local/default_local_datasource.dart'
    as _i533;
import 'package:dog_gromming_website/data/datasources/local/local_data_source.dart'
    as _i692;
import 'package:dog_gromming_website/data/datasources/remote/default_remote_datasource.dart'
    as _i987;
import 'package:dog_gromming_website/data/datasources/remote/remote_datasource.dart'
    as _i670;
import 'package:dog_gromming_website/data/services/api_service.dart' as _i578;
import 'package:dog_gromming_website/di/di.dart' as _i915;
import 'package:dog_gromming_website/domain/use_cases/send_email_use_case.dart'
    as _i1023;
import 'package:dog_gromming_website/env/env.dart' as _i374;
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart'
    as _i1025;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    final diModule = _$DiModule();
    final apiServiceModule = _$ApiServiceModule();
    gh.singleton<_i374.Env>(() => diModule.env);
    gh.singleton<_i1025.MainNavigator>(() => diModule.navigator);
    gh.lazySingleton<_i578.ApiService>(() => apiServiceModule.httpClient);
    gh.factory<_i692.LocalDataSource>(() => _i533.DefaultLocalDataSource());
    gh.factory<_i670.RemoteDatasource>(() => _i987.DefaultRemoteDatasource(
          gh<_i578.ApiService>(),
          gh<_i374.Env>(),
        ));
    gh.factory<_i1023.SendEmailUseCase>(
        () => _i1023.SendEmailUseCase(gh<_i670.RemoteDatasource>()));
    return this;
  }
}

class _$DiModule extends _i915.DiModule {}

class _$ApiServiceModule extends _i578.ApiServiceModule {}
