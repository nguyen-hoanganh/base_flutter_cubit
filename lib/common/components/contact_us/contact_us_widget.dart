import 'package:cbp_mobile_app_flutter/common/components/button/gesture_detector/gesture_detector_throttle/gesture_detector_throttle.dart';
import 'package:cbp_mobile_app_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactUsSize { s, m, l }

class ContactUsWidget extends StatelessWidget {
  final ContactUsSize contactUsSize;
  const ContactUsWidget({super.key, ContactUsSize? contactUsSize})
      : contactUsSize = contactUsSize ?? ContactUsSize.l;

  void launchAnotherApp(String path) async {
    if (!await launchUrl(
      Uri.parse(path),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {

    double size = getSize();
    double gap = getGap();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetectorThrottle(
          configs: GestureDetectorConfigs(
            onTap: () {
              launchAnotherApp("https://www.instagram.com/mycbpofficial/");
            },
            child: Assets.svgs.instagram.svg(
              width: size,
              height: size,
            ),
          ),
        ),
        Gap(gap),
        GestureDetectorThrottle(
          configs: GestureDetectorConfigs(
            onTap: () {
              launchAnotherApp("https://www.facebook.com/mycbpofficial/");
            },
            child: Assets.svgs.facebook.svg(
              width: size,
              height: size,
            ),
          ),
        ),
        Gap(gap),
        GestureDetectorThrottle(
          configs: GestureDetectorConfigs(
            onTap: () {
              launchAnotherApp("https://www.linkedin.com/company/mycbpofficial/");
            },
            child: Assets.svgs.linkedin.svg(
              width: size,
              height: size,
            ),
          ),
        ),
        Gap(gap),
        GestureDetectorThrottle(
          configs: GestureDetectorConfigs(
            onTap: () {
              launchAnotherApp("https://twitter.com/mycbpofficial");
            },
            child: Assets.svgs.x.svg(
              width: size,
              height: size,
            ),
          ),
        ),
      ],
    );
  }

  double getSize() {
    switch (contactUsSize) {
      case ContactUsSize.s:
        return 24.s;
      case ContactUsSize.m:
        return 32.s;
      case ContactUsSize.l:
        return 46.s;
    }
  }
    double getGap() {
    switch (contactUsSize) {
      case ContactUsSize.s:
        return 24.s;
      case ContactUsSize.m:
        return 32.s;
      case ContactUsSize.l:
        return 32.s;
    }
  }
}
