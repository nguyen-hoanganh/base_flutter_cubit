import 'dart:convert';

import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/inapp_debug_console_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/inapp_debug_console_manager/inapp_debug_console_model.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/network_custom_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum Level { debug, info, warning, error, alien }

void logDebug(String message, {Level level = Level.info}) {
  // Define ANSI escape codes for different colors
  const String resetColor = '\x1B[0m';
  const String redColor = '\x1B[31m'; // Red
  const String greenColor = '\x1B[32m'; // Green
  const String yellowColor = '\x1B[33m'; // Yellow
  const String cyanColor = '\x1B[36m'; // Cyan

  // Get the current time in hours, minutes, and seconds
  final now = DateTime.now();
  final timeString =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

  // Only log messages if the app is running in debug mode
  if (kDebugMode) {
    try {
      String logMessage;
      switch (level) {
        case Level.debug:
          logMessage = '$cyanColor[DEBUG][$timeString] $message$resetColor';
          break;
        case Level.info:
          logMessage = '$greenColor[INFO][$timeString] $message$resetColor';
          break;
        case Level.warning:
          logMessage =
              '$yellowColor[WARNING][$timeString] $message $resetColor';
          break;
        case Level.error:
          logMessage = '$redColor[ERROR][$timeString] $message $resetColor';
          break;
        case Level.alien:
          logMessage = '$redColor[ALIEN][$timeString] $message $resetColor';
          break;
      }
      //print(logMessage);
      // Use the DebugPrintCallback to ensure long strings are not truncated
      debugPrint(logMessage);
    } catch (e) {
      print(e.toString());
    }
  }
}

// Define an interceptor that logs the requests and responses
class LoggerInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    // Log the error request and error message
    logDebug(
      'onError: ${options.method} request => $requestPath',
      level: Level.error,
    );
    logDebug(
      'onError: ${err.error}, Message: ${err.message}',
      level: Level.error,
    );

    InAppDebugConsoleManager.shared.add(
      InAppDebugConsoleModel(
        type: InAppDebugConsoleModelType.error,
        message:
            '${options.method}: ${options.baseUrl}${options.path} \n-----------------\nRequest: \n${options.extra[NetworkCustomKeys.rawDataRequest]} \n-----------------\n Message: ${err.error} \n-----------------\n Error: ${err.response}',
      ),
    );

    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Log the response status code and data
    logDebug(
      'Response: StatusCode: ${response.statusCode}, Data: ${response.data}',
      level: Level.info,
    );

    InAppDebugConsoleManager.shared.add(
      InAppDebugConsoleModel(
        type: InAppDebugConsoleModelType.verbose,
        message:
            '${response.requestOptions.method}: ${response.requestOptions.baseUrl}${response.requestOptions.path} \n-----------------\nRequest: \n${response.requestOptions.extra[NetworkCustomKeys.rawDataRequest]}\n-----------------\nResponse: StatusCode: ${response.statusCode}\n-----------------\nData: ${jsonEncode(response.data)}',
        // stackTrace: stackTrace,
      ),
    );
    // Call the super class to continue handling the response
    return super.onResponse(response, handler);
  }
}
