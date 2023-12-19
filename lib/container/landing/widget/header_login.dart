import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HeaderLanding extends StatelessWidget {
  const HeaderLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.s, right: 17.s, top: 28.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Assets.images.logoCBP.image(
            width: 145.s,
            height: 27.s,
          ),
          const Spacer(),
          // const SwitchLanguage(),
        ],
      ),
    );
  }
}
