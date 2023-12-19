import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterLogin extends StatelessWidget {
  const FooterLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 107.5.s, vertical: 16.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconButton(
            Assets.svgs.instagram.svg(height: 24.s),
            'https://www.instagram.com/mycbpofficial/',
          ),
          iconButton(
            Assets.svgs.facebook.svg(height: 24.s),
            'https://www.facebook.com/mycbpofficial/',
          ),
          iconButton(
            Assets.svgs.linkedin.svg(height: 24.s),
            'https://www.linkedin.com/company/mycbpofficial/',
          ),
          iconButton(
            Assets.svgs.x.svg(height: 24.s),
            'https://twitter.com/mycbpofficial',
          ),
        ],
      ),
    );
  }

  Widget iconButton(Widget icon, String url) {
    return GestureDetector(
      onTap: (() async {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }),
      child: icon,
    );
  }
}
