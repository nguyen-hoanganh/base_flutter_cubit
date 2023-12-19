import 'package:cbp_mobile_app_flutter/datasource/models/requests/request_token_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/request_token_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/network_custom_keys.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/token/request')
  Future<RequestTokenResponse> request(
    @Body() RequestTokenRequest request, {
    @Header(NetworkCustomKeys.isShowLoading) bool? isShowLoading,
    @Header(NetworkCustomKeys.isEncryptRequest) bool? isEncryptRequest,
    @Header(NetworkCustomKeys.isShowDefaultErrorDialog)
        bool? isShowDefaultErrorDialog,
    @Header(NetworkCustomKeys.isShowDefaultDioErrorDialog)
        bool? isShowDefaultDioErrorDialog,
    @Header(NetworkCustomKeys.whitelistErrorCode)
        List<String>? whitelistErrorCode,
  });
}
