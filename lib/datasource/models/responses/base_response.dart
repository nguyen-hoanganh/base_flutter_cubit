// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BaseResponse {
  String? errorCode;
  String? errorMessage;
  String? status;

  BaseResponse({
    this.errorCode,
    this.errorMessage,
    this.status,
  });

  factory BaseResponse.fromRawJson(String str) =>
      BaseResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "status": status,
      };
}
