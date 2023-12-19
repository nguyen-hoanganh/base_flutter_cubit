import 'dart:async';
import 'dart:developer';

import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/loading_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/notification/notification_manager.dart';
import 'package:cbp_mobile_app_flutter/common/utils/smart_otp_utils.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/requests/secure_tac_info_request.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/data_state.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:cbp_mobile_app_flutter/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'landing_cubit.freezed.dart';
part 'landing_state.dart';

class DataLogin {
  String username;
  String password;

  DataLogin({required this.username, required this.password});

  factory DataLogin.fromJson(Map<String, dynamic> json) {
    return DataLogin(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(const LandingState.initial()) {
    test();
  }

  void test() async {
    bool isActive = await SmartOtpUtils.isActiveTAC(userId: "14");
    log("testtesttesttest $isActive");
  }

    Future secureTacInfo() async {
    final response = await getIt.get<AppRepository>().secureTacInfo(
          SecureTacInfoRequest(
            username: AppManager.shared.username,
          ),
        );

    if (response is DataSuccess) {
      return response.data;
    }
    return null;
  }

  void checkDisabledButton(String text) {
    if (text.isNotEmpty) {
      emit(state.copyWith(isDisableButton: true));
    } else {
      emit(state.copyWith(isDisableButton: false));
    }
  }

  void validatePassword(String password) {
    if (password.length < 6) {
      emit(
        state.copyWith(
          isDisableButtonPassword: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isDisableButtonPassword: true,
        ),
      );
    }
  }

  void login(
    String password, {
    String? biometric,
    String? type,
    Function? handleCallBack,
  }) async {
    LoadingManager.shared.show();
    String username = AppManager.shared.username;
    if (NotificationManager.shared.tokenFirebase.isEmpty) {
      await NotificationManager.shared.getToken();
    }

    LoadingManager.shared.hide();
  }
}

Future<void> doActiveTAC(String? secureTacEnabled) async {
  bool isActive =
      await SmartOtpUtils.isActiveTAC(userId: AppManager.shared.userId);

  log("isActiveisActive $isActive");
  log("secureTacEnabled $secureTacEnabled");

  if (isActive && secureTacEnabled == "1") return;

  String? getInitializeRegisterTAC =
      await SmartOtpUtils.getInitializeRegisterTAC(
    userId: AppManager.shared.userId,
  );
}
