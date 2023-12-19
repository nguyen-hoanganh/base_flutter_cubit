// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cbp_mobile_app_flutter/datasource/models/requests/request_token_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/request_token_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/api_service/auth/auth_api.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl({
    required AuthApi authApi,
  }) : _authApi = authApi;

  @override
  Future<RequestTokenResponse> request(
    RequestTokenRequest request, {
    bool? isShowLoading,
    bool? isShowDefaultErrorDialog,
    bool? isShowDefaultDioErrorDialog,
    bool? isEncryptRequest,
    String? partnerCode,
    List<String>? whitelistErrorCode,
  }) {
    return _authApi.request(
      request,
      isShowLoading: isShowLoading,
      isEncryptRequest: isEncryptRequest,
      isShowDefaultErrorDialog: isShowDefaultErrorDialog,
      isShowDefaultDioErrorDialog: isShowDefaultDioErrorDialog,
      whitelistErrorCode: whitelistErrorCode,
    );
  }
}
