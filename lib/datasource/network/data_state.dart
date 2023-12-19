import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;
  String status = "";

  final HttpResponse<T>? originResponse;

  DataState({
    this.data,
    this.error,
    this.originResponse,
  });
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
    required HttpResponse<T>? originResponse,
  }) : super(
          data: data,
          error: null,
          originResponse: originResponse,
        ) {
    if (data != null) {
      try {
        final dataJson = safeToJson(data);
        status = dataJson["status"] ?? status;
      } catch (e) {
        ///
      }
    }
  }
}

class DataFailed<T> extends DataState<T> {
  DataFailed({
    required DioError error,
    HttpResponse<T>? originResponse,
    T? data,
  }) : super(
          data: data,
          error: error,
          originResponse: originResponse,
        ) {
    if (data != null) {
      try {
        final dataJson = safeToJson(data);
        status = dataJson["status"] ?? status;
      } catch (e) {
        ///
      }
    }
  }
}

Map<String, dynamic> safeToJson(object) {
  if (object == null) return {};

  try {
    try {
      return object.toMap();
    } catch (e) {
      try {
        return object.toJson();
      } catch (e) {
        final dataJsonStr = jsonEncode(object);
        final dataJson = jsonDecode(dataJsonStr);

        return Map<String, dynamic>.from(dataJson);
      }
    }
  } catch (e) {
    ///
    return {};
  }
}
