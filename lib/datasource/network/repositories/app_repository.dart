import 'package:cbp_mobile_app_flutter/datasource/models/requests/secure_tac_info_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/secure_tac_info_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/data_state.dart';

abstract class AppRepository {
  // Future<DataState<VerifyUsernameResponse>> verifyUsername(
  //   VerifyUsernameRequest request, {
  //   bool? isShowLoading,
  //   bool? isShowDefaultErrorDialog,
  //   bool? isShowDefaultDioErrorDialog,
  //   String? partnerCode,
  //   List<String>? whitelistErrorCode,
  // });

    Future<DataState<SecureTacInfoResponse>> secureTacInfo(
    SecureTacInfoRequest request, {
    bool? isShowLoading,
    bool? isShowDefaultErrorDialog,
    bool? isShowDefaultDioErrorDialog,
    String? partnerCode,
    List<String>? whitelistErrorCode,
  });
}
