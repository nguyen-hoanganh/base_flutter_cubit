// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cbp_mobile_app_flutter/datasource/models/requests/secure_tac_info_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/secure_tac_info_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/api_service/app_api.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/data_state.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repository_helper.dart';

class AppRepositoryImpl implements AppRepository {
  final AppApi _appApi;

  AppRepositoryImpl({
    required AppApi appApi,
  }) : _appApi = appApi;

  // @override
  // Future<DataState<VerifyUsernameResponse>> verifyUsername(
  //   VerifyUsernameRequest request, {
  //   bool? isShowLoading,
  //   bool? isShowDefaultErrorDialog,
  //   bool? isShowDefaultDioErrorDialog,
  //   String? partnerCode,
  //   List<String>? whitelistErrorCode,
  // }) {
  //   return repositoryHelper(
  //     _appApi.verifyUsername(
  //       request,
  //       isShowLoading: isShowLoading,
  //       isShowDefaultErrorDialog: isShowDefaultErrorDialog,
  //       isShowDefaultDioErrorDialog: isShowDefaultDioErrorDialog,
  //       whitelistErrorCode: whitelistErrorCode,
  //     ),
  //   );
  // }

  @override
  Future<DataState<SecureTacInfoResponse>> secureTacInfo(
    SecureTacInfoRequest request, {
    bool? isShowLoading,
    bool? isShowDefaultErrorDialog,
    bool? isShowDefaultDioErrorDialog,
    String? partnerCode,
    List<String>? whitelistErrorCode,
  }) {
    return repositoryHelper(
      _appApi.secureTacInfo(
        request,
        isShowLoading: isShowLoading,
        isShowDefaultErrorDialog: isShowDefaultErrorDialog,
        isShowDefaultDioErrorDialog: isShowDefaultDioErrorDialog,
        whitelistErrorCode: whitelistErrorCode,
      ),
    );
  }
}
