import 'dart:convert';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/requests/base_request.dart';

class VerifyUsernameRequest extends BaseRequest {
  String? username;

  VerifyUsernameRequest({
    this.username,
  });

  factory VerifyUsernameRequest.fromRawJson(String str) =>
      VerifyUsernameRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerifyUsernameRequest.fromJson(Map<String, dynamic> json) =>
      VerifyUsernameRequest(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "deviceId": AppManager.shared.deviceId,
      };
}
