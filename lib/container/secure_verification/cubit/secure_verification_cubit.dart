import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/utils/smart_otp_utils.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/secure_tac_info_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secure_verification_cubit.freezed.dart';
part 'secure_verification_state.dart';

class SecureVerificationCubit extends Cubit<SecureVerificationState> {
  SecureVerificationCubit(this._appRepository)
      : super(const SecureVerificationState.initial());

  // ignore: unused_field
  final AppRepository _appRepository;

  Future<void> secureTacInfo(
    SecureTacInfoResponse secureTacInfoResponse,
  ) async {
    List<TxnDetail> listTnxDetail = [];
    listTnxDetail = secureTacInfoResponse.txnDetail ?? [];

    listTnxDetail.sort((a, b) {
      int first = int.tryParse(a.rank ?? '1') ?? 1;
      int second = int.tryParse(b.rank ?? '1') ?? 1;
      return first.compareTo(second);
    });

    if (secureTacInfoResponse.txnDetail == null ||
        secureTacInfoResponse.txnDetail!.isEmpty) {
      return emit(
        state.copyWith(
          secureVerificationType: SecureVerificationType.none,
        ),
      );
    }

    if ((secureTacInfoResponse.amount == "0" ||
            secureTacInfoResponse.amount == null) &&
        secureTacInfoResponse.monetary == "0") {
      emit(
        state.copyWith(
          secureVerificationType: SecureVerificationType.nonMonetary,
        ),
      );
    }
    emit(
      state.copyWith(
        listTnxDetail: listTnxDetail,
        amount: secureTacInfoResponse.amount,
        ibTxnId: secureTacInfoResponse.ibTxnId,
      ),
    );
  }

  Future<String> getSecureData({
    required String transactionType,
    required String approvalStatus,
  }) async {
    // doActiveTAC();

    Map<String, dynamic> createTAC = await SmartOtpUtils.doCreateTAC(
      userId: AppManager.shared.userId,
      arrayVerify: [
        AppManager.shared.userId,
        AppManager.shared.deviceId,
        state.ibTxnId ?? "",
        approvalStatus,
        AppManager.shared.ipAddress,
        transactionType
      ],
    );

    if (createTAC.keys.contains('dataSecure')) {
      return createTAC["dataSecure"];
    }
    return "";
  }

  // Future<void> doActiveTAC() async {
  //   print("do create tac");
  //   bool isActive =
  //       await SmartOtpUtils.isActiveTAC(userId: AppManager.shared.userId);

  //   if (isActive) return;

  //   String? getInitializeRegisterTAC =
  //       await SmartOtpUtils.getInitializeRegisterTAC(
  //     userId: AppManager.shared.userId,
  //   );

  //   var activateSecureTacResponse =
  //       await getIt.get<AppRepository>().activateSecureTac(
  //             ActivateSecureTacRequest(
  //               userId: AppManager.shared.userId,
  //               sessionId: AppManager.shared.sessionId,
  //               activeData: getInitializeRegisterTAC,
  //             ),
  //           );

  //   if (activateSecureTacResponse.data?.status == '00') {
  //     String? softData = activateSecureTacResponse.data?.softData;
  //     if (softData != null && softData.isNotEmpty) {
  //       bool isActive = await SmartOtpUtils.onSuccessRegisterTAC(
  //         userId: AppManager.shared.userId,
  //         dataTacServer: softData,
  //       );

  //       logDebug(
  //         "SmartOtpUtils - onSuccessRegisterTAC ->>>> $isActive",
  //         level: Level.info,
  //       );
  //     }
  //   }
  // }
}
