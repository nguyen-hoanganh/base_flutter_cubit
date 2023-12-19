import 'dart:convert';

class BaseResponseEncrypt {
  Message? message;
  String? signature;

  BaseResponseEncrypt({
    this.message,
    this.signature,
  });

  factory BaseResponseEncrypt.fromRawJson(String str) =>
      BaseResponseEncrypt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseResponseEncrypt.fromJson(Map<String, dynamic> json) =>
      BaseResponseEncrypt(
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        signature: json["signature"],
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
        "signature": signature,
      };
}

class Message {
  Header? header;
  Body? body;

  Message({
    this.header,
    this.body,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "body": body?.toJson(),
      };
}

class Body {
  String? data;
  String? secret;

  Body({
    this.data,
    this.secret,
  });

  factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        data: json["data"],
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "secret": secret,
      };
}

class Header {
  String? messageId;
  dynamic sendTimeStamp;
  String? version;

  Header({
    this.messageId,
    this.sendTimeStamp,
    this.version,
  });

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        messageId: json["messageId"],
        sendTimeStamp: json["sendTimeStamp"],
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "sendTimeStamp": sendTimeStamp,
        "version": version,
      };
}
