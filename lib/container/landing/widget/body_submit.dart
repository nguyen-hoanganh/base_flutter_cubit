import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/button/button.dart';
import 'package:cbp_mobile_app_flutter/common/components/input/normal_input/normal_input.dart';
import 'package:cbp_mobile_app_flutter/common/components/input/password_input/password_input.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/string_ext.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/landing/cubit/landing_cubit.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class BodySubmit extends StatefulWidget {
  const BodySubmit({super.key, required this.isUsername});

  final bool isUsername;

  @override
  State<BodySubmit> createState() => _BodySubmitState();
}

class _BodySubmitState extends State<BodySubmit> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _password = TextEditingController();
  late final _cubit = context.read<LandingCubit>();

  @override
  void dispose() {
    _focusNode.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingCubit, LandingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.s),
          child: Column(
            children: [
              PasswordInput(
                configs: NormalInputConfigs(
                  controller: _password,
                  prefixIcon: Assets.svgs.icPassword.svg(),
                  labelText: AppLocalizations.current.password,
                  errorText: state.errorPassword,
                  labelTextStyle: CommonTextStyle.bodyB4
                      .copyWith(color: CommonColors.neutralColor3),
                  textStyle: CommonTextStyle.supportFontSubtitle1
                      .copyWith(color: CommonColors.neutralColor2),
                  boxBorder: Border.all(color: CommonColors.neutralColor6),
                  floatingLabelTextStyle: CommonTextStyle.bodyB2
                      .copyWith(color: CommonColors.neutralColor3),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20),
                  ],
                  onChanged: (pass) {
                    trimSpaceText(pass, _password);
                    _cubit.validatePassword(pass);
                  },
                ),
              ),
              Gap(16.s),
              buildButtonSubmit(state, widget.isUsername),
              if (!widget.isUsername)
                Button(
                  configs: ButtonConfigs(
                    isContentUnderline: true,
                    backgroundColor: Colors.transparent,
                    content: AppLocalizations.current.back,
                    contentStyle: CommonTextStyle.bodyB3
                        .copyWith(color: CommonColors.neutralColor1),
                    onTap: () {
                      AppRouter.router.pop();
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButtonSubmit(
    LandingState state,
    bool isUsername,
  ) {
    return Button(
      configs: ButtonConfigs(
        state: ButtonState.default$,
        type: ButtonType.primary,
        disabled: !state.isDisableButtonPassword ? true : false,
        content: isUsername
            ? AppLocalizations.current.logIn
            : AppLocalizations.current.submit,
        contentStyle:
            CommonTextStyle.bodyB3.copyWith(color: CommonColors.neutralColor7),
        padding: EdgeInsets.symmetric(vertical: 12.s),
        onTap: () {
          AppManager.shared.isCheckBiometric = false;
          _cubit.login(_password.text);
        },
      ),
    );
  }
}
