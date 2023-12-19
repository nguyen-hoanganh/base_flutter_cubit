import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/common/utils/session_timeout_manager.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';

class AppManager {
  AppManager._internal();
  static AppManager? _instance;

  static AppManager get shared {
    _instance ??= AppManager._internal();

    return _instance!;
  }

  bool get isUserLoggedIn => sessionId != "";

  SharedPreferencesManager get pref => getIt<SharedPreferencesManager>();

  SessionTimeoutManager get sessionManager => getIt<SessionTimeoutManager>();

  dynamic newsFeed = [];

  String accessToken = "";
  String secretPhrase = "";
  String deviceId = "";
  String deviceOS = "";
  String deviceModel = "";
  String ipAddress = "10.0.0.1";
  String sessionId = "";
  String userId = "";
  String username = "";
  String password = "";
  String fullName = "";
  String idNo = "";
  String idType = "";
  String lastLogin = "";
  String versionApp = "";
  String passwordAttemptLimit = "";
  int sessionTimeOut = 0;
  bool isMultipleLogin = false;
  DateTime sessionTime = DateTime.now();
  bool isCheckBiometric = false;
  String maintenanceMode = "1";
  String maintenanceMessage = ""; // 0 = false , 1 = true
  String coolingOff = "1"; // 0 = false , 1 = true
}
