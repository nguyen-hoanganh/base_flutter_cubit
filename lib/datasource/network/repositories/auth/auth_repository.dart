

import 'package:cbp_mobile_app_flutter/datasource/models/requests/request_token_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/request_token_response.dart';

abstract class AuthRepository {
  
  Future<RequestTokenResponse> request(
    RequestTokenRequest request,{
    bool? isShowLoading,
    bool? isEncryptRequest,
    bool? isShowDefaultErrorDialog,
    bool? isShowDefaultDioErrorDialog,
    String? partnerCode,
    List<String>? whitelistErrorCode,
  });
}
