import 'package:cbp_mobile_app_flutter/datasource/network/error_code/error_code_en.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/error_code/error_code_model.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/error_code/error_code_ms.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';
import 'package:cbp_mobile_app_flutter/l10n/localization_cubit.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class ErrorCodeLocalization {
  static const _defaultLocalizationSupportedLanguage =
      LocalizationSupportedLanguage.en;
  static final _defaultErrorCodeModel = ErrorCodeEn();

  final List<ErrorCodeModel> _datasource = [
    _defaultErrorCodeModel,
    ErrorCodeMs(),
  ];
  final List<ErrorCodeModel> _extendDatasource;
  final BuildContext? context;

  ErrorCodeLocalization({
    required List<ErrorCodeModel> extendDatasource,
    this.context,
  }) : _extendDatasource = extendDatasource;

  static String getDefaultTitle(
    String? errorCode, {
    BuildContext? context,
  }) {
    final errorCodeLocalization = ErrorCodeLocalization(
      extendDatasource: [
        _defaultErrorCodeModel,
        ErrorCodeMs(),
      ],
      context: context,
    );

    return errorCodeLocalization.getTitle(errorCode);
  }

  static String getDefaultMessage(
    String? errorCode, {
    BuildContext? context,
    String? errorMessage,
  }) {
    final errorCodeLocalization = ErrorCodeLocalization(
      extendDatasource: [],
      context: context,
    );
    final alternativeMessage =
        errorMessage != null && errorMessage.isNotEmpty ? errorMessage : "";

    return errorCodeLocalization.getMessage(errorCode).isNotEmpty
        ? errorCodeLocalization.getMessage(errorCode)
        : alternativeMessage;
  }

  String getTitle(String? errorCode) {
    final errorCodeValue = _getErrorCodeValue(errorCode);
    if (errorCodeValue is String) {
      return "";
    } else if (errorCodeValue is Map) {
      return errorCodeValue["title"] ?? "";
    } else {
      return "";
    }
  }

  String getMessage(
    String? errorCode, {
    String? errorMessage,
  }) {
    final errorCodeValue = _getErrorCodeValue(errorCode);
    if (errorCodeValue is String) {
      return errorCodeValue;
    } else if (errorCodeValue is Map) {
      return errorCodeValue["message"] ?? "";
    } else if (errorMessage != null) {
      return errorMessage;
    } else {
      return "";
    }
  }

  Locale? _getCurrentLocale() {
    try {
      final localizationCubit = getIt.get<LocalizationCubit>();

      return localizationCubit.state.locale;
    } catch (e) {
      return null;
    }
  }

  ErrorCodeModel? _getCurrentErrorCodeModel(List<ErrorCodeModel> datasource) {
    ErrorCodeModel? errorCodeModel;

    final locale = _getCurrentLocale();

    if (locale == null) {
      errorCodeModel ??= datasource.firstWhereOrNull(
        (e) =>
            e.getLocalizationSupportedLanguage() ==
            _defaultLocalizationSupportedLanguage,
      );

      return errorCodeModel;
    }
    errorCodeModel ??= datasource.firstWhereOrNull(
      (e) =>
          e.getLocalizationSupportedLanguage().languageCode ==
          locale.languageCode,
    );

    return errorCodeModel;
  }

  ErrorCodeModel? _getCurrentExtendErrorCodeModel() =>
      _getCurrentErrorCodeModel(_extendDatasource);
  ErrorCodeModel _getCurrentDefaultErrorCodeModel() =>
      _getCurrentErrorCodeModel(_datasource) ?? _defaultErrorCodeModel;

  dynamic _getErrorCodeValue(String? errorCode) {
    if (errorCode == null || errorCode.isEmpty) return "";

    return _getCurrentExtendErrorCodeModel()?.getData()[errorCode] ??
        _getCurrentDefaultErrorCodeModel().getData()[errorCode];
  }
}
