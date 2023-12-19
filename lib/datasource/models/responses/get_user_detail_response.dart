import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_detail_response.freezed.dart';
part 'get_user_detail_response.g.dart';

@freezed
class GetUserDetailResponse with _$GetUserDetailResponse {
  const factory GetUserDetailResponse({
    String? status,
    String? errorCode,
    String? errorMessage,
    String? icNo,
    String? name,
    String? mobile,
    String? email,
    String? address1,
    String? address2,
    String? address3,
    String? address4,
    String? postCode,
    String? citizenship,
    DateTime? dob,
    String? title,
    String? gender,
    String? race,
  }) = _GetUserDetailResponse;

  factory GetUserDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserDetailResponseFromJson(json);
}
