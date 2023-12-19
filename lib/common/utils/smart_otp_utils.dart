import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tacmodule/tac.dart';

class SmartOtpUtils {
  static String? accessToken;

  ///Get String data TAC SDK sends to TAC Server to register for authentication with TAC
  static Future<String?> getInitializeRegisterTAC({
    required String userId,
  }) async {
    String strDomainActive = await TACSDK.getInitializeRegisterTAC(userId);
    return strDomainActive;

    // String first =
    //     "{ \"clientId\": \"imocha\", \"clientSecret\": \"ZCooNeQ0NLh8e6UH\" }";
    // //Giả lập MBSERVER: Tạo Active TOKEN Trên MB Server
    // Map<String, dynamic>? dataFirst = await postV("/authorization", first);
    // if (dataFirst == null) {
    //   return "Error Server";
    // }
    // //TAC SDK - create signature with TAC
    // String strDomainActive = await TACSDK.getInitializeRegisterTAC(userId);
    // //Giả lập MBSERVER: Khởi tạo kích hoạt với TACcho user
    // String dataActive =
    //     "{\"clientId\": \"imocha\", \"userId\": \"$userId\", \"username\": \"$userId\", \"mobileNo\": \"$userId\", \"cusName\": \"$userId\", \"cif\": \"$userId\", \"activeData\": \"$strDomainActive\"}";

    // Map<String, dynamic>? dataActiveFromTacSerrver =
    //     await postV("/active", dataActive);

    // if (dataActiveFromTacSerrver == null ||
    //     !dataActiveFromTacSerrver.containsKey("softData")) {
    //   return "Error Server";
    // }

    // bool rs = await TACSDK.onSuccessRegisterTAC(
    //   userId,
    //   dataActiveFromTacSerrver["softData"],
    // );
    // if (!rs) {
    //   return "Register fail";
    // }

    // //Success
    // return null;
  }

  ///Send data to TAC Server -> TAC SDK
  static Future<bool> onSuccessRegisterTAC({
    required String userId,
    required String dataTacServer,
  }) async {
    return TACSDK.onSuccessRegisterTAC(
      userId,
      dataTacServer,
    );
  }

  ///Create TAC
  static Future<Map<String, dynamic>> doCreateTAC({
    required String userId,
    required List<String> arrayVerify,
  }) async {
    Map<String, dynamic> respSDK =
        await TACSDK.doCreateTAC(userId, arrayVerify);
    log("doCreateTAC");
    // arrayVerify.map((e) => log(e));
    log(jsonEncode(arrayVerify));

    // {isActived: true, dataSecure: {"success":""}}
    return respSDK;
  }

  ///check active Tac
  static Future<bool> isActiveTAC({required String userId}) async {
    bool isActiveTAC = await TACSDK.isActiveTAC(userId);

    return isActiveTAC;
  }

  ///clear Smart OTP
  static void doClearTAC({required String userId}) {
    TACSDK.doClearTAC(userId);
  }

  static Future<Map<String, dynamic>?> postV(String path, String data) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://45.252.250.113:9001/v1",
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      ),
    );

    final rss = await dio.post(
      path,
      data: data,
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
      ),
    );
    if (rss.statusCode == 200) {
      if (rss.data["access_token"] != null) {
        accessToken = rss.data["access_token"];
      }
      return rss.data;
    } else {}
    return null;
  }
}
