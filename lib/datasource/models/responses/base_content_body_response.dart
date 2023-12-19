import 'dart:convert';

class ContentBodyResponse {
  String? data;
  String? secret;

  ContentBodyResponse({
    this.data,
    this.secret,
  });

  factory ContentBodyResponse.fromJson(String str) =>
      ContentBodyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContentBodyResponse.fromMap(Map<String, dynamic> json) =>
      ContentBodyResponse(
        data: json["data"],
        secret: json["secret"],
      );

  Map<String, dynamic> toMap() => {
        "data": data,
        "secret": secret,
      };
}
