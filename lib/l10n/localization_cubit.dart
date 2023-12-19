import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/managers/share_pref_manager.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_cubit.freezed.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit()
      : super(LocalizationState.initial(locale: _getDefaultLocale()));

  List<Locale> get supportedLocales => AppLocalizations.supportedLocales
      .map((e) => Locale.fromSubtags(languageCode: e.languageCode))
      .toList();

  Future<void> init() async {
    String? currentLanguageCode =
        AppManager.shared.pref.getString(SharedPreferenceKey.keyLanguageCode);

    if (currentLanguageCode == null || currentLanguageCode.isEmpty) {
      currentLanguageCode = _getDefaultLocale().languageCode;
      AppManager.shared.pref.putString(
        SharedPreferenceKey.keyLanguageCode,
        currentLanguageCode,
      );
    }

    emit(
      state.copyWith(
        locale: Locale.fromSubtags(languageCode: currentLanguageCode),
      ),
    );
  }

  void changeShouldBlurScreen(bool shouldBlur) {
    emit(state.copyWith(shouldBlur: shouldBlur));
  }

  void changeLocale(Locale locale) async {
    AppManager.shared.pref.putString(
      SharedPreferenceKey.keyLanguageCode,
      locale.languageCode,
    );

    emit(
      state.copyWith(
        locale: Locale.fromSubtags(languageCode: locale.languageCode),
      ),
    );
  }

  void notifyUpdatedLocale() {
    emit(
      state.copyWith(
        notificationUpdatedLocale: !state.notificationUpdatedLocale,
      ),
    );
  }

  static Locale _getDefaultLocale() {
    return const Locale.fromSubtags(
      languageCode: 'en',
    );
  }
}
