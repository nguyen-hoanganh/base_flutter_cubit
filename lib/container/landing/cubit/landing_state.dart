part of 'landing_cubit.dart';

@freezed
class LandingState with _$LandingState {
  const factory LandingState.initial({
    @Default(false) bool isDisableButton,
    @Default(false) bool isDisableButtonPassword,
    String? errorUsername,
    String? errorPassword,
  }) = _LandingState;
}
