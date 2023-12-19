import 'dart:io';

import 'package:cbp_mobile_app_flutter/datasource/network/data_state.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

Future<DataState<T>> repositoryHelper<T>(
  Future<HttpResponse<T>> apiFunction, {
  bool Function(T e)? customConditionCheckResult,
  bool isDifferResponse = false,
}) async {
  try {
    HttpResponse<T>? response;
    DioError? dioError;
    try {
      response = await apiFunction;
    } on DioError catch (err) {
      dioError = err;

      ///
    }
    if (response == null) {
      // return DataFailed when response == null
      if (dioError == null) {
        return DataFailed(
          error: DioError(
            type: DioErrorType.response,
            requestOptions: RequestOptions(path: ""),
          ),
        );
      }

      // return DataFailed when parse response wrong type
      if (dioError.toString().contains("is not a subtype of type")) {
        return DataFailed(
          error: DioError(
            type: DioErrorType.response,
            requestOptions: RequestOptions(path: ""),
          ),
        );
      }

      return DataFailed(
        error: dioError,
      );
    }

    bool isResultOk = false;
    if (customConditionCheckResult != null) {
      isResultOk = customConditionCheckResult.call(response.data);
    } else {
      try {
        final dataJson = safeToJson(response.data);

        isResultOk = dataJson["status"] == "00";
      } catch (_) {}
    }

    return response.response.statusCode == HttpStatus.ok && isResultOk
        ? DataSuccess(
            data: response.data,
            originResponse: response,
          )
        : DataFailed(
            error: dioError ??
                DioError(
                  error: null,
                  requestOptions: response.response.requestOptions,
                  response: response.response,
                  type: DioErrorType.response,
                ),
            data: response.data,
            originResponse: response,
          );
  } on DioError catch (e) {
    return DataFailed(
      error: e,
    );
  }
}
