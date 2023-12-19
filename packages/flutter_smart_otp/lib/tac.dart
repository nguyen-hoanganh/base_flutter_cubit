import 'dart:convert';

import 'package:flutter/services.dart';

class TACSDK {
  static const platform = MethodChannel('com.thd.flutter/tacsoft');

  /// getInitializeRegisterTAC
  /// Lấy infor từ TAC SDK gửi Server TAC đăng ký TAC
  static Future<String> getInitializeRegisterTAC(String userId) async {
    var arguments = {
      'userId': userId,
    };
    final String dataForTac =
        await platform.invokeMethod('getInitializeRegisterTAC', arguments);
    return dataForTac;
  }

  //onSuccessRegisterTAC
  //Nhận Response từ Server Tac, truyền userId + trường data từ response để SDK đăng ký TAC
  static Future<bool> onSuccessRegisterTAC(
      String userId, String dataTacServer,) async {
    var arguments = {
      'userId': userId,
      'dataTacServer': dataTacServer,
    };
    String? response =
        await platform.invokeMethod('onSuccessRegisterTAC', arguments);
    if (response?.isNotEmpty == true) {
      Map<String, dynamic> data = jsonDecode(response!);
      return data["isActived"];
    }
    return false;
  }

  //Tạo request khi request server
  // Các trường thông tin chủ động thống nhất với server MB để MB và Server khớp
  static Future<Map<String, dynamic>> doCreateTAC(
      String userId, List<String> arrayVerify,) async {
    var arguments = {'userId': userId, 'dataTransaction': arrayVerify.join()};
    String? response = await platform.invokeMethod('doCreateTAC', arguments);
    if (response?.isNotEmpty == true) {
        return {"isActived": true, "dataSecure": response!};
    }
    return {"isActived": false};
  }

  // Kiểm tra đã Active Tac
  static Future<bool> isActiveTAC(String userId) async {
    var arguments = {'userId': userId};
    String? response = await platform.invokeMethod('isActiveTAC', arguments);
    if (response == null) {
      return false;
    }
    Map<String, dynamic> data = jsonDecode(response);
    return data["isActived"];
  }

  // Huỷ Smart OTP hoặc đổi user
  static void doClearTAC(String userId) async {
    var arguments = {'userId': userId};
    platform.invokeMethod('doClearTAC', arguments);
  }
}
