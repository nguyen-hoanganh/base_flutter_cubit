import 'dart:convert';

class RequestTokenRequest {
  String? clientId;
  String? clientSecret;

  RequestTokenRequest({
    this.clientId,
    this.clientSecret,
  });

  factory RequestTokenRequest.fromRawJson(String str) =>
      RequestTokenRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestTokenRequest.fromJson(Map<String, dynamic> json) =>
      RequestTokenRequest(
        clientId: json["clientId"],
        clientSecret: json["clientSecret"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "clientSecret": clientSecret,
      };
}
