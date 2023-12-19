import 'package:cbp_mobile_app_flutter/common/components/contact_us/contact_us_widget.dart';
import 'package:cbp_mobile_app_flutter/common/components/function_selection_dropdown/function_selection_dropdown.dart';
import 'package:cbp_mobile_app_flutter/common/components/popup/modal_bottom/modal_bottom.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> onShowContactBottomsheet() async {
  // String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map(
  //         (MapEntry<String, String> e) =>
  //             '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
  //       )
  //       .join('&');
  // }

  void launch(Uri uri) {
    try {
      launchUrl(uri);
    } catch (e) {
      ///
    }
  }

  ModalBottom(
    configs: ModalBottomConfigs(
      size: ModalBottomSize.fixed,
      title: "Choose Contact Line",
      footer: ModalBottomFooter.noButton,
      fixedConfigs: ModalBottomFixedConfigs(
        size: ModalBottomFixedSize.m,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ContactUsWidget(
              contactUsSize: ContactUsSize.m,
            ),
            Gap(32.s),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FunctionSelectionDropdown(
                    configs: FunctionSelectionDropdownConfigs(
                      prefixIcon: Container(
                        width: 24.s,
                        height: 24.s,
                        padding: EdgeInsets.all(3.s),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.primaryColor1,
                        ),
                        child: Assets.svgs.icContactPhone.svg(),
                      ),
                      title: "1-300-88-7650",
                      onTap: () {
                        final Uri telLaunchUri = Uri(
                          scheme: 'tel',
                          path: '1300887650',
                        );
                        launch(telLaunchUri);
                      },
                    ),
                  ),
                  Gap(8.s),
                  FunctionSelectionDropdown(
                    configs: FunctionSelectionDropdownConfigs(
                      prefixIcon: Container(
                        width: 24.s,
                        height: 24.s,
                        padding: EdgeInsets.all(3.s),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.primaryColor1,
                        ),
                        child: Assets.svgs.icWhatsapp.svg(),
                      ),
                      title: "019-756 7650",
                      onTap: () async {
                        try {
                          launchUrl(
                            Uri.parse("https://wa.me/0197567650?text= "),
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          ///
                        }
                      },
                    ),
                  ),
                  Gap(8.s),
                  FunctionSelectionDropdown(
                    configs: FunctionSelectionDropdownConfigs(
                      prefixIcon: Container(
                        width: 24.s,
                        height: 24.s,
                        padding: EdgeInsets.all(3.s),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CommonColors.primaryColor1,
                        ),
                        child: Assets.svgs.icContactGg.svg(),
                      ),
                      title: "info@cbp.com.my",
                      onTap: () {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'info@cbp.com.my',
                          // query: encodeQueryParameters(<String, String>{
                          //   'subject': 'Need Help',
                          // }),
                        );
                        launch(emailLaunchUri);
                      },
                    ),
                  ),
                  Gap(24.s),
                  Text(
                    AppLocalizations.current.operationHours,
                    style: CommonTextStyle.bodyB2,
                  ),
                  Gap(4.s),
                  Text(
                    AppLocalizations.current.infoOperation,
                    style: CommonTextStyle.bodyB4
                        .copyWith(color: CommonColors.secondaryColor2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ).show();
}
