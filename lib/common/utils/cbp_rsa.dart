import 'package:cbp_mobile_app_flutter/datasource/models/responses/base_content_body_response.dart';
import 'package:flutter/services.dart';

class FlutterCbpRsa {
  static const MethodChannel _channel = MethodChannel('cbp_rsa');

  static Future<Map<dynamic, dynamic>> aesEncryption(String data) async {
    return await _channel.invokeMethod('aesEncryption', [data]);
  }

  static Future<String> rsaEncryption() async {
    return await _channel.invokeMethod('rsaEncryption');
  }

  static Future<String> getSignature(String data) async {
    return await _channel.invokeMethod('getSignature', [data]);
  }

  static Future<String> aesDecryption(ContentBodyResponse data) async {
    return await _channel.invokeMethod('aesDecryption', [data.toMap()]);
  }

  static Future<String> dataEncryption() async {
    return await _channel.invokeMethod('publicKeyData');
  }

  static Future<String> dataDecryption() async {
    return await _channel.invokeMethod('privateKeyData');
  }
}
