part of 'localization_cubit.dart';

@freezed
class LocalizationState with _$LocalizationState {
  factory LocalizationState.initial({
    @Default(Locale("en")) Locale locale,
    @Default(false) bool notificationUpdatedLocale,
    @Default(false) bool shouldBlur,
  }) = _Initial;
}
