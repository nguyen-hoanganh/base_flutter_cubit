import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_configs.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/information/information.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/string_ext.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/secure_verification/cubit/secure_verification_cubit.dart';
import 'package:cbp_mobile_app_flutter/container/secure_verification/secure_verification_agrument.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SecureVerificationPage extends StatefulWidget {
  final SecureVerificationAgrument agrument;
  const SecureVerificationPage({
    super.key,
    required this.agrument,
  });

  @override
  State<SecureVerificationPage> createState() => _SecureVerificationPageState();
}

class _SecureVerificationPageState extends State<SecureVerificationPage> {
  late final _cubit = context.read<SecureVerificationCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.secureTacInfo(widget.agrument.secureTacInfoResponse);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecureVerificationCubit, SecureVerificationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.s),
          child: Column(
            children: [
              _buildContent(state),
              state.secureVerificationType != SecureVerificationType.none
                  ? Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: AppLocalizations.current.pleaseContact,
                            style: CommonTextStyle.scriptSubtitle1.copyWith(
                              color: CommonColors.secondaryColor2,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppLocalizations.current.contentBlock2,
                                style: CommonTextStyle.scriptSubtitle1.copyWith(
                                  color: CommonColors.accentColor2,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.current.contentBlock3,
                                style: CommonTextStyle.scriptSubtitle1.copyWith(
                                  color: CommonColors.secondaryColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(16.s),
                        Button(
                          configs: ButtonConfigs(
                            content: AppLocalizations.current.approve,
                            onTap: () {
                              //Todo something
                            },
                          ),
                        ),
                        Gap(8.s),
                        Button(
                          configs: ButtonConfigs(
                            content: AppLocalizations.current.reject,
                            type: ButtonType.secondary,
                            onTap: () {
                              //todo something
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(SecureVerificationState state) {
    final DateTime time = DateTime.now();

    switch (state.secureVerificationType) {
      case SecureVerificationType.monetary:
        return Expanded(
          child: Column(
            children: [
              Text(
                "Transaction Verification",
                style: CommonTextStyle.bodyB2.copyWith(
                  color: CommonColors.neutralColor2,
                  fontSize: 18.fs,
                ),
              ),
              Gap(8.s),
              Text(
                "MYR ${state.amount?.moneyFormat}",
                style: CommonTextStyle.bodyB1
                    .copyWith(color: CommonColors.secondaryColor1),
              ),
              Gap(8.s),
              Text(
                DateFormat("dd/MM/yyyy - HH:mm").format(time),
                textAlign: TextAlign.center,
                style: CommonTextStyle.supportFontSubtitle3.copyWith(
                  color: CommonColors.neutralColor3,
                ),
              ),
              Gap(12.s),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(12.s),
                      ...List.generate(
                        state.listTnxDetail?.length ?? 0,
                        (idx) => Information(
                          configs: InformationConfigs(
                            leadingText: state.listTnxDetail?[idx].key,
                            trailingText: state.listTnxDetail?[idx].value,
                            isShowDivider: true,
                            aDividerConfigs: ADividerConfigs(
                              type: ADividerType.line,
                              color: CommonColors.secondaryColor3,
                              strokeWidth: 1.s,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                AppLocalizations.current.warningExecTransaction,
                textAlign: TextAlign.center,
                style: CommonTextStyle.scriptSubtitle1.copyWith(
                  color: CommonColors.secondaryColor2,
                ),
              ),
            ],
          ),
        );
      case SecureVerificationType.nonMonetary:
        return Expanded(
          child: Column(
            children: [
              // Text(
              //   AppLocalizations.current.titleChangePassword,
              //   style: CommonTextStyle.bodyB2.copyWith(
              //     color: CommonColors.neutralColor2,
              //     fontSize: 18.fs,
              //   ),
              // ),
              // Gap(8.s),
              // Text(
              //   DateFormat("dd/MM/yyyy - HH:mm").format(time),
              //   textAlign: TextAlign.center,
              //   style: CommonTextStyle.supportFontSubtitle3.copyWith(
              //     color: CommonColors.neutralColor3,
              //   ),
              // ),
              // Gap(12.s),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(12.s),
                    ...List.generate(
                      state.listTnxDetail?.length ?? 0,
                      (idx) => Information(
                        configs: InformationConfigs(
                          leadingText: state.listTnxDetail?[idx].key,
                          trailingText: state.listTnxDetail?[idx].value,
                          isShowDivider: true,
                          aDividerConfigs: ADividerConfigs(
                            type: ADividerType.line,
                            color: CommonColors.secondaryColor3,
                            strokeWidth: 1.s,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.s),
              Text(
                DateFormat("dd/MM/yyyy - HH:mm").format(time),
                textAlign: TextAlign.center,
                style: CommonTextStyle.supportFontSubtitle3.copyWith(
                  color: CommonColors.neutralColor3,
                ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.current.performThisChangeMsg,
                textAlign: TextAlign.center,
                style: CommonTextStyle.scriptSubtitle1.copyWith(
                  color: CommonColors.secondaryColor2,
                ),
              ),
            ],
          ),
        );
      case SecureVerificationType.none:
        return Column(
          children: [
            Gap(64.s),
            Assets.images.secureTAC.image(
              width: 100.s,
              height: 100.s,
            ),
            Gap(24.s),
            Text(
              AppLocalizations.current.sVRequest,
              textAlign: TextAlign.center,
              style: CommonTextStyle.bodyB2.copyWith(
                color: CommonColors.neutralColor2,
              ),
            ),
            Gap(4.s),
            Text(
              AppLocalizations.current.desNoSVRequest,
              textAlign: TextAlign.center,
              style: CommonTextStyle.scriptSubtitle1.copyWith(
                color: CommonColors.secondaryColor2,
              ),
            ),
          ],
        );
    }
  }
}
