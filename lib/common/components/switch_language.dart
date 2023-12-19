import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/list_ext.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:cbp_mobile_app_flutter/l10n/app_localizations.dart';
import 'package:cbp_mobile_app_flutter/l10n/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SwitchLanguage extends StatefulWidget {
  const SwitchLanguage({super.key});

  @override
  State<SwitchLanguage> createState() => _SwitchLanguageState();
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return Row(
          children: AppLocalizations.switchLanguageLocales
              .map(
                (e) => GestureDetectorThrottle(
                  configs: GestureDetectorConfigs(
                    onTap: () async {
                      context.read<LocalizationCubit>().changeLocale(e.locale);
                    },
                    child: Text(
                      e.display.toUpperCase(),
                      style: CommonTextStyle.bodyB4.copyWith(
                        height: 1.2,
                        color:
                            state.locale.languageCode == e.locale.languageCode
                                ? CommonColors.primaryColor1
                                : CommonColors.neutralColor1,
                      ),
                    ),
                  ),
                ),
              )
              .toList()
              .separator(
                (index) => Container(
                  width: 1.s,
                  height: 17.s,
                  color: CommonColors.neutralColor1,
                  margin: EdgeInsets.symmetric(horizontal: 8.s),
                ),
              ),
        );
      },
    );
  }
}
