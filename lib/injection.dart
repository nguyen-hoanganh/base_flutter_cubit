import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/configs/config_const.dart';
import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/common/utils/session_timeout_manager.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/api_service/app_api.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/api_service/auth/auth_api.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/app_interceptor.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository_impl.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/auth/auth_repository.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/auth/auth_repository_impl.dart';
import 'package:cbp_mobile_app_flutter/l10n/localization_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'common/configs/config_manager.dart';
import 'datasource/network/logger_interceptor.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> setupInjection() async {
  getIt.init();
  await getIt.allReady();
  await getIt.getAsync<SharedPreferencesManager>();
  getIt.registerSingleton<SessionTimeoutManager>(SessionTimeoutManager());
}

@module
abstract class RegisterModule {
  @Named('BaseUrl')
  String get baseUrl => ConfigManager.getInstance().apiBaseUrl;
  @Named('TimeoutInMilliseconds')
  int get timeoutInMilliseconds => ConfigConst.defaultConnectTimeout;

  @lazySingleton
  Dio dio(
    @Named('BaseUrl') String url,
    @Named('TimeoutInMilliseconds') int timeout,
  ) {
    return Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: timeout,
      ),
    )..interceptors.addAll([
        LogInterceptor(
          request: false,
          responseBody: false,
          requestBody: false,
          requestHeader: false,
          responseHeader: false,
        ),
        AppInterceptor(),
        LoggerInterceptor()
      ]);
  }

  @lazySingleton
  AppRouter get appRouter;

  @lazySingleton
  LocalizationCubit get localizationCubit;

  @lazySingleton
  AuthApi authApi(@Named('BaseUrl') String url) {
    return AuthApi(getIt<Dio>(), baseUrl: url);
  }

  @lazySingleton
  AppApi appApi(@Named('BaseUrl') String url) {
    return AppApi(getIt<Dio>(), baseUrl: url);
  }

  @lazySingleton
  AuthRepository authRepository() {
    return AuthRepositoryImpl(authApi: getIt<AuthApi>());
  }

  @lazySingleton
  AppRepository appRepository() {
    return AppRepositoryImpl(appApi: getIt<AppApi>());
  }
}
