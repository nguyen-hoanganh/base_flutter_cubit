import 'dart:convert';

class RequestTokenResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  RequestTokenResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  factory RequestTokenResponse.fromRawJson(String str) =>
      RequestTokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestTokenResponse.fromJson(Map<String, dynamic> json) =>
      RequestTokenResponse(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
