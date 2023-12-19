import 'dart:convert';

class BaseHeaderRequest {
  String? version;
  String? messageId;
  DateTime? sendTimestamp;

  BaseHeaderRequest({
    this.version,
    this.messageId,
    this.sendTimestamp,
  });

  factory BaseHeaderRequest.fromRawJson(String str) =>
      BaseHeaderRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseHeaderRequest.fromJson(Map<String, dynamic> json) => BaseHeaderRequest(
        version: json["version"],
        messageId: json["messageId"],
        sendTimestamp: json["sendTimestamp"] == null
            ? null
            : DateTime.parse(json["sendTimestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "messageId": messageId,
        "sendTimestamp": sendTimestamp?.toIso8601String(),
      };
}
