import 'dart:convert';

import 'package:cbp_mobile_app_flutter/datasource/models/requests/base_request.dart';

class SecureTacInfoRequest  extends BaseRequest{
  String? username;

  SecureTacInfoRequest({
    this.username,
  });

  factory SecureTacInfoRequest.fromRawJson(String str) =>
      SecureTacInfoRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SecureTacInfoRequest.fromJson(Map<String, dynamic> json) =>
      SecureTacInfoRequest(
        username: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "deviceId": deviceId,
      };
}
