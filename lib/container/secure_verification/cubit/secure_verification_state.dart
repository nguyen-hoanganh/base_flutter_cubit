part of 'secure_verification_cubit.dart';

enum SecureVerificationType { monetary, nonMonetary, none }

@freezed
class SecureVerificationState with _$SecureVerificationState {
  const factory SecureVerificationState.initial({
    @Default([]) List<TxnDetail>? listTnxDetail,
    @Default(SecureVerificationType.monetary)
        SecureVerificationType secureVerificationType,
    @Default("") String? amount,
    @Default("") String? ibTxnId,
  }) = _Initial;
}
