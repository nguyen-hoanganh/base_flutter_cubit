part of 'dashboard_cubit.dart';

enum DashboardStatus {
  initState,
  loading,
  loaded,
}

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial({
    @Default(DashboardStatus.initState) DashboardStatus status,
    String? message,
    @Default(GetUserDetailResponse()) GetUserDetailResponse user,
    bool? isActiveBiometric,
    bool? isShowMenuDrawer,
  }) = _Initial;
}
