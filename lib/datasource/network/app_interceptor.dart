import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cbp_mobile_app_flutter/common/configs/config_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/loading_manager.dart';
import 'package:cbp_mobile_app_flutter/common/utils/cbp_rsa.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/requests/request_token_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/base_content_body_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/base_response_encrypt.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/dio_error.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/dio_handle_err.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/logger_interceptor.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/network_custom_keys.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/response_handle_err.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart'; // For caching responses (optional).

class AppInterceptor extends Interceptor {
  List<Map<String, dynamic>> failedRequests = [];
  bool isRenew = false;
  RequestOptions? plainData;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      plainData = options;
      // handle isShowLoading
      final isShowLoading =
          options.headers[NetworkCustomKeys.isShowLoading] ?? true;

      final isEncryptRequest =
          options.headers[NetworkCustomKeys.isEncryptRequest] ?? true;
      if (isShowLoading) {
        final uniqueLoadingKey =
            "${options.method}_${options.uri}_${DateTime.now().microsecondsSinceEpoch}";

        LoadingManager.shared.show(
          tag: uniqueLoadingKey,
        );
        options.extra[NetworkCustomKeys.uniqueLoadingKey] = uniqueLoadingKey;
      }

      // tranfer headers to extras
      options.extra[NetworkCustomKeys.isShowLoading] = isShowLoading;
      options.extra[NetworkCustomKeys.isShowDefaultErrorDialog] =
          options.headers[NetworkCustomKeys.isShowDefaultErrorDialog] ?? true;
      options.extra[NetworkCustomKeys.isShowDefaultDioErrorDialog] =
          options.headers[NetworkCustomKeys.isShowDefaultDioErrorDialog];
      options.extra[NetworkCustomKeys.whitelistErrorCode] =
          options.headers[NetworkCustomKeys.whitelistErrorCode];

      options.extra[NetworkCustomKeys.isEncryptRequest] = isEncryptRequest;
      log(jsonEncode(options.data));
      if (!isRenew) {
        logDebug(
          'onRequest: Plain Data => ${jsonEncode(options.data)}',
          level: Level.debug,
        );
      }

      options.extra[NetworkCustomKeys.rawDataRequest] =
          jsonEncode(options.data);

      options.headers.addAll({
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AppManager.shared.accessToken}",
      });

      if (isEncryptRequest) {
        //default encrypt data request

        options = await handleDataIsMap(
          options,
        );
      }
    } catch (e) {
      ///
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    Response result = response;

    try {
      isRenew = false;
      // handle isShowLoading
      final isShowLoading =
          response.requestOptions.extra[NetworkCustomKeys.isShowLoading];

      final isShowDefaultErrorDialog = response
          .requestOptions.extra[NetworkCustomKeys.isShowDefaultErrorDialog];

      if (isShowLoading == null || isShowLoading == true) {
        LoadingManager.shared.hide(
          tag:
              response.requestOptions.extra[NetworkCustomKeys.uniqueLoadingKey],
        );
      }

      if (response.requestOptions.extra[NetworkCustomKeys.isEncryptRequest]) {
        //handle decrypt data
        dynamic data = await handleDecryptResponse(response);

        if (isShowDefaultErrorDialog) {
          //Handle error status
          handleResponse(
            resultResponse: jsonDecode(data),
            whitelistErrorCode: response
                .requestOptions.extra[NetworkCustomKeys.whitelistErrorCode],
          );
        }

        result = Response(
          data: jsonDecode(data),
          headers: response.headers,
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          redirects: response.redirects,
          isRedirect: response.isRedirect,
          extra: response.extra,
        );
      }
    } catch (e) {
      ///
    }
    super.onResponse(result, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // ignore: deprecated_member_use
      getIt.get<Dio>().interceptors.requestLock.lock();
      // ignore: deprecated_member_use
      getIt.get<Dio>().interceptors.responseLock.lock();

      RequestOptions options = err.requestOptions;

      Dio retryDio = Dio(
        BaseOptions(
          baseUrl: ConfigManager.getInstance().apiBaseUrl,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        ),
      );
      // handle refresh token
      var response = await retryDio.post(
        '/token/request',
        data: RequestTokenRequest(
          clientId: "alphaway",
          clientSecret: "Alph4w@y123",
        ),
      );

      AppManager.shared.accessToken = response.data['access_token'] ?? "";

      options.headers.addAll({
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AppManager.shared.accessToken}",
      });

      isRenew = true;

      // ignore: deprecated_member_use
      getIt.get<Dio>().interceptors.requestLock.unlock();
      // ignore: deprecated_member_use
      getIt.get<Dio>().interceptors.responseLock.unlock();
      LoadingManager.shared.hide(
        tag: err.requestOptions.extra[NetworkCustomKeys.uniqueLoadingKey],
      );
      final responseRetry = await getIt.get<Dio>().fetch(options);

      return handler.resolve(responseRetry);
    } else {
      // Do something with response error
      // handle isShowLoading
      final isShowLoading =
          err.requestOptions.extra[NetworkCustomKeys.isShowLoading];

      if (isShowLoading == null || isShowLoading == true) {
        LoadingManager.shared.hide(
          tag: err.requestOptions.extra[NetworkCustomKeys.uniqueLoadingKey],
        );
      }
      final isShowDefaultDioErrorDialog = err
          .requestOptions.extra[NetworkCustomKeys.isShowDefaultDioErrorDialog];

      if (isShowDefaultDioErrorDialog == null ||
          isShowDefaultDioErrorDialog == true) {
        DioCustomErrorType.fromDioErrorType(err).then((errorType) {
          DioErrorHandler.handle(
            errorType,
            dioError: err,
          );
        });
      }
    }
    super.onError(err, handler);
  }

  Future<void> renewToken(DioError err, ErrorInterceptorHandler handler) async {
    Dio retryDio = Dio(
      BaseOptions(
        baseUrl: ConfigManager.getInstance().apiBaseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );
    // handle refresh token
    var response = await retryDio.post(
      '/token/request',
      data: RequestTokenRequest(
        clientId: "alphaway",
        clientSecret: "Alph4w@y123",
      ),
    );
    isRenew = false;
    var parsedResponse = response.data;
    if (response.statusCode == 401) {
      return handler.reject(err);
    }

    AppManager.shared.accessToken = parsedResponse['access_token'] ?? "";

    for (var i = 0; i < failedRequests.length; i++) {
      DioError error = failedRequests[i]['err'] as DioError;

      RequestOptions requestOptions = error.requestOptions;

      ErrorInterceptorHandler interceptorHandler =
          failedRequests[i]['handler'] as ErrorInterceptorHandler;

      requestOptions.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppManager.shared.accessToken}'
      };
      final responseFetch = await retryDio.request(
        error.requestOptions.path,
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
        options: Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        ),
      );

      if (responseFetch.statusCode != null &&
          responseFetch.statusCode! ~/ 100 == 2) {
        return interceptorHandler.resolve(responseFetch);
      } else {
        return interceptorHandler.reject(
          DioError(requestOptions: requestOptions),
        );
      }
    }
    // retryRequests();
  }

  retryRequests() async {
    Dio retryDio = Dio(
      BaseOptions(
        baseUrl: ConfigManager.getInstance().apiBaseUrl,
      ),
    );

    for (var i = 0; i < failedRequests.length; i++) {
      RequestOptions requestOptions =
          failedRequests[i]['err'].requestOptions as RequestOptions;

      requestOptions.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppManager.shared.accessToken}'
      };

      await retryDio.fetch(requestOptions).then(
            failedRequests[i]['handler'].resolve,
            onError: (error) =>
                failedRequests[i]['handler'].reject(error as DioError),
          );
    }

    failedRequests = [];
  }

  Future<String> handleDecryptResponse(Response response) async {
    dynamic data = response.data;
    BaseResponseEncrypt baseResponseEncrypt =
        BaseResponseEncrypt.fromJson(jsonDecode(data));

    String dataDecrypt = await FlutterCbpRsa.aesDecryption(
      ContentBodyResponse(
        data: baseResponseEncrypt.message?.body?.data,
        secret: baseResponseEncrypt.message?.body?.secret,
      ),
    );
    return dataDecrypt;
  }

  Future<RequestOptions> handleDataIsMap(
    RequestOptions options,
  ) async {
    if (isRenew) return options;

    dynamic data = options.data;
    Map dataBody = await FlutterCbpRsa.aesEncryption(jsonEncode(data));

    String? dataEncrypt =
        dataBody['data'] != null ? dataBody['data'] as String : null;
    String? secretEncrypt =
        dataBody['secret'] != null ? dataBody['secret'] as String : null;

    DateTime time = DateTime.now();

    Map<String, dynamic> mesageData = {
      "header": {
        "version": "1.0",
        "messageId": DateFormat('yyyyMMddHHmmsssss').format(time),
        "sendTimeStamp": DateFormat('yyyy-MM-dd HH:mm:ss.sss').format(time)
      },
      "body": {
        "data": dataEncrypt,
        "secret": secretEncrypt,
      }
    };

    String getSignature =
        await FlutterCbpRsa.getSignature(jsonEncode(mesageData));

    Map<String, dynamic> bodyData = {
      "message": mesageData,
      "signature": getSignature,
    };
    data = bodyData;

    final result = options.copyWith(data: data);

    return result;
  }

  void handleResponse({
    Map<String, dynamic>? resultResponse,
    dynamic whitelistErrorCode,
  }) {
    final status = resultResponse?["status"];
    final errorCode = resultResponse?["errorCode"];

    if (whitelistErrorCode == null || whitelistErrorCode is! List<String>) {
      whitelistErrorCode = <String>[];
    }

    if (errorCode == 'ECN00003') {
      // handle multiple login
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // AppRouter.clearAndNavigate(Routes.login);
      });
    } else {
      // handle error code
      if (status != null &&
          status.isNotEmpty &&
          !whitelistErrorCode.contains(errorCode) &&
          !["00"].contains(status)) {
        ResponseErrorCodeHandler.handle(
          status,
          errorCode: resultResponse?["errorCode"] ?? "",
          responseMessage: resultResponse?["errorMessage"] ?? "",
        );
      }
    }
  }
}
