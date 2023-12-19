import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/container/dashboard/widget/popup_biometric_confirm.dart';
import 'package:cbp_mobile_app_flutter/datasource/models/responses/get_user_detail_response.dart';
import 'package:cbp_mobile_app_flutter/datasource/network/repositories/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AppRepository _appRepository;

  DashboardCubit(this._appRepository) : super(const DashboardState.initial());

  void popupConfirmBiometricHandler(GlobalKey<ScaffoldState> key) {
    final isFirstTime =
        AppManager.shared.pref.getBool(SharedPreferenceKey.firstTimeLogin);
    if (isFirstTime == null) {
      showPopupConfirmBiometric(() {
        key.currentState!.openDrawer();
      });
      AppManager.shared.pref.putBool(SharedPreferenceKey.firstTimeLogin, true);
    }
  }

  Future<void> handleBiometric(bool value) async {
    emit(state.copyWith(isActiveBiometric: value));
    AppManager.shared.pref.putBool(SharedPreferenceKey.activeBiometric, value);
  }

  Future<void> handleActiveMenuDrawer(bool value) async {
    emit(state.copyWith(isShowMenuDrawer: value));
  }
}
