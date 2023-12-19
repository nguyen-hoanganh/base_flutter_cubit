import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';

class BaseRequest {
  final String deviceId;
  BaseRequest() : deviceId = AppManager.shared.deviceId;
}
