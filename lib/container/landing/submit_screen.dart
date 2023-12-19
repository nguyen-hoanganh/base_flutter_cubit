import 'package:cbp_mobile_app_flutter/common/app_routes.dart';
import 'package:cbp_mobile_app_flutter/common/components/radio_button/radio_button.dart';
import 'package:cbp_mobile_app_flutter/common/managers/app_manager.dart';
import 'package:cbp_mobile_app_flutter/common/screen/base_screen.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold.dart';
import 'package:cbp_mobile_app_flutter/common/screen/scaffold/base_scaffold_configs.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/body_submit.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/footer_customer.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/footer_login.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/header_login.dart';
import 'package:cbp_mobile_app_flutter/container/landing/widget/promotion_login.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  bool isUsername = false;
  bool isChoose = false;

  @override
  void initState() {
    _loadUsername();
    super.initState();
  }

  void _loadUsername() async {
    if (AppManager.shared.password.isNotEmpty) {
      setState(() {
        isUsername = true;
        isChoose = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scaffoldBuilder: () => BaseScaffold(
        configs: BaseScaffoldConfigs(
          backgroundColor:
              isUsername ? Colors.transparent : CommonColors.neutralColor7,
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const HeaderLanding(),
                    Gap(36.s),
                    isUsername
                        ? Column(
                            children: [
                              Text(
                                AppLocalizations.current.heloCbp.toUpperCase(),
                                style: CommonTextStyle.bodyB2
                                    .copyWith(fontSize: 24.s),
                              ),
                              Gap(7.5.s),
                              Text(
                                AppLocalizations.current.welcome,
                                style: CommonTextStyle.bodyB2,
                              ),
                            ],
                          )
                        : Text(
                            AppLocalizations.current.verifySecureWord,
                            style: CommonTextStyle.bodyB4.copyWith(
                              color: CommonColors.neutralColor3,
                            ),
                          ),
                    Gap(8.s),
                    isUsername
                        ? Gap(50.s)
                        : Text(
                            AppManager.shared.secretPhrase.toUpperCase(),
                            style: CommonTextStyle.supportFontSubtitle1,
                          ),
                    Gap(8.s),
                    isUsername ? const SizedBox() : secureWord(),
                    Gap(24.s),
                    isChoose
                        ? BodySubmit(isUsername: isUsername)
                        : SizedBox(
                            height: 160.s,
                          ),
                    Gap(isUsername ? 50.s : 17.s),
                    const PromotionLogin(),
                    isUsername ? const FooterCustomer() : const FooterLogin()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget secureWord() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.s),
      padding: EdgeInsets.all(12.s),
      decoration: BoxDecoration(
        color: CommonColors.secondaryColor5,
        borderRadius: BorderRadius.all(
          Radius.circular(4.s),
        ),
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.current.titleSecureWord,
            style: CommonTextStyle.bodyB4,
          ),
          Gap(8.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _radioChooseSecure(AppLocalizations.current.yes, isChoose, () {
                setState(() {
                  isChoose = true;
                });
              }),
              SizedBox(
                width: 48.s,
              ),
              _radioChooseSecure(AppLocalizations.current.no, false, () {
                AppRouter.router.pop();
              })
            ],
          ),
        ],
      ),
    );
  }

  Widget _radioChooseSecure(
    String label,
    bool isChoose,
    Function onChooseSecure,
  ) {
    return Row(
      children: [
        RadioButton(
          configs: RadioButtonConfigs(
            width: 20.s,
            height: 20.s,
            value: isChoose,
            onChange: ((value) {
              onChooseSecure();
            }),
          ),
        ),
        SizedBox(width: 12.s),
        Text(
          label,
          style: CommonTextStyle.bodyB4,
        )
      ],
    );
  }
}
