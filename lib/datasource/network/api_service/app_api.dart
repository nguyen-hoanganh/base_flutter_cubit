import 'package:cbp_mobile_app_flutter/datasource/models/requests/secure_tac_info_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/secure_tac_info_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/network_custom_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  // @POST('/mobile/verifyUsername')
  // Future<HttpResponse<VerifyUsernameResponse>> verifyUsername(
  //   @Body() VerifyUsernameRequest request, {
  //   @Header(NetworkCustomKeys.isShowLoading) bool? isShowLoading,
  //   @Header(NetworkCustomKeys.isShowDefaultErrorDialog)
  //       bool? isShowDefaultErrorDialog,
  //   @Header(NetworkCustomKeys.isShowDefaultDioErrorDialog)
  //       bool? isShowDefaultDioErrorDialog,
  //   @Header(NetworkCustomKeys.whitelistErrorCode)
  //       List<String>? whitelistErrorCode,
  // });

  @POST('/mobile/secureTacInfo')
  Future<HttpResponse<SecureTacInfoResponse>> secureTacInfo(
    @Body() SecureTacInfoRequest request, {
    @Header(NetworkCustomKeys.isShowLoading) bool? isShowLoading,
    @Header(NetworkCustomKeys.isShowDefaultErrorDialog)
        bool? isShowDefaultErrorDialog,
    @Header(NetworkCustomKeys.isShowDefaultDioErrorDialog)
        bool? isShowDefaultDioErrorDialog,
    @Header(NetworkCustomKeys.whitelistErrorCode)
        List<String>? whitelistErrorCode,
  });
}
