// ignore_for_file: prefer_interpolation_to_compose_strings

abstract class NetworkCustomKeys {
  static const String _defaultPrefix = "NetworkCustomKeys_";

  static const String uniqueLoadingKey = _defaultPrefix + "uniqueLoadingKey";
  static const String isEncryptRequest = _defaultPrefix + "isEncryptRequest";

  // Header Keys
  static const String isShowLoading = _defaultPrefix + "isShowLoading";
  static const String isShowDefaultErrorDialog =
      _defaultPrefix + "isShowDefaultErrorDialog";
  static const String whitelistErrorCode =
      _defaultPrefix + "whitelistErrorCode";
  static const String isShowDefaultDioErrorDialog =
      _defaultPrefix + "isShowDefaultDioErrorDialog";

  static const String rawDataRequest = "rawDataRequest";
}
