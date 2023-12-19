import 'dart:convert';
import 'dart:io';

import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/configs/config_const.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/common/utils/cbp_rsa.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:intl/intl.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static void copyToClipBoard(String? content) async {
    try {
      await Clipboard.setData(ClipboardData(text: content));

      ScaffoldMessenger.of(AppRouter.rootNavigatorKey.currentContext!)
          .showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            AppLocalizations.current.copySuccess,
            style: CommonTextStyle.bodyB4
                .copyWith(color: CommonColors.neutralColor7),
          ),
          backgroundColor: CommonColors.primaryColor2,
          clipBehavior: Clip.hardEdge,
        ),
      );
    } catch (_) {}
  }

  static Future<dynamic> getDeviceInformation() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, String> deviceInfo = {};

    try {
      if (Platform.isAndroid) {
        // For Android devices
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceInfo['deviceId'] = androidInfo.deviceIdCommon.toString();
        deviceInfo['deviceOS'] = 'Android';
        deviceInfo['deviceModel'] = androidInfo.model.toString();
      } else if (Platform.isIOS) {
        // For iOS devices
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceInfo['deviceId'] = iosInfo.deviceIdCommon.toString();
        deviceInfo['deviceOS'] = 'iOS';
        deviceInfo['deviceModel'] = iosInfo.model.toString();
      }
    } catch (_) {
      // print('Error: $e');
    }

    return deviceInfo;
  }

  static Future<String> getIpAddress() async {
    var ipAddress = IpAddress(type: RequestType.json);
    dynamic data = await ipAddress.getIpAddress();
    return data['ip'];
  }

  static String formatDateTimeNow() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
    return formattedDate;
  }

  static Image convertBase64toImage(codeBase64, {BoxFit fit = BoxFit.cover}) {
    var image = base64.decode(codeBase64.toString());
    return Image.memory(
      image,
      fit: fit,
    );
  }

  static MemoryImage convertBase64toMemoryImage(codeBase64) {
    Uint8List img = base64Decode(codeBase64.toString());
    return MemoryImage(
      img,
    );
  }

  static void contactCustomerService() {
    launchUrlString("tel://${ConfigConst.customerServicePhone}");
  }

  static Future<String> encodeEncryptedDataBase64(dynamic data) async {
    dynamic dataEncrypt;
    try {
      final getPublicKey = await FlutterCbpRsa.dataEncryption();
      String publicKeyString =
          '-----BEGIN PUBLIC KEY-----\n$getPublicKey\n-----END PUBLIC KEY-----';
      final publicKeyParser = RSAKeyParser();
      dynamic publicKey = publicKeyParser.parse(publicKeyString);
      final encrypter = Encrypter(RSA(publicKey: publicKey));
      dataEncrypt = encrypter.encrypt(jsonEncode(data));
    } catch (_) {}
    String encryptedDataString = base64.encode(dataEncrypt.bytes);
    return encryptedDataString;
  }

  static Future<String> decodeEncryptedDataBase64(
    String encryptedDataString,
  ) async {
    List<int> encryptedDataBytes = base64.decode(encryptedDataString);
    Encrypted encryptedData = Encrypted(Uint8List.fromList(encryptedDataBytes));
    dynamic decryptData;
    try {
      final getPrivateKey = await FlutterCbpRsa.dataDecryption();
      String privateKeyString =
          '-----BEGIN PRIVATE KEY-----\n$getPrivateKey\n-----END PRIVATE KEY-----';

      final privateKeyParser = RSAKeyParser();
      dynamic privateKey =
          privateKeyParser.parse(privateKeyString) as RSAPrivateKey;

      final encrypter = Encrypter(RSA(privateKey: privateKey));
      decryptData = encrypter.decrypt(encryptedData);
    } catch (_) {}
    return decryptData;
  }
}
