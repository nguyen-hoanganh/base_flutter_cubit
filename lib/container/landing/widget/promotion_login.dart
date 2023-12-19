import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class PromotionLogin extends StatefulWidget {
  const PromotionLogin({super.key});

  @override
  State<PromotionLogin> createState() => _PromotionLoginState();
}

class _PromotionLoginState extends State<PromotionLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(5.s),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.s),
                child: Text(
                  'News & Announcements',
                  style: CommonTextStyle.bodyB2,
                ),
              ),
            ],
          ),
        ),
        Gap(20.s),
      ],
    );
  }
}

class ValuePromotion {
  String? images;
  String? title;
  String? content;

  ValuePromotion({this.images, this.content, this.title});
}
