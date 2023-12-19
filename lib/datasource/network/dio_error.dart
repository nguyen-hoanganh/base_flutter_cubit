
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

enum DioCustomErrorType {
  parsing(""),
  httpStatus(""),
  timeout(""),
  disconnected(""),
  cancel(""),
  other("");

  final String errorCode;
  const DioCustomErrorType(this.errorCode);

  static Future<DioCustomErrorType> fromDioErrorType(DioError dioError) async {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return DioCustomErrorType.timeout;
      case DioErrorType.response:
        return DioCustomErrorType.httpStatus;
      case DioErrorType.cancel:
        return DioCustomErrorType.cancel;
      default:
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          return DioCustomErrorType.disconnected;
        }
        return DioCustomErrorType.other;
    }
  }
}
