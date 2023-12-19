import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_configs.dart';
import 'package:cbp_mobile_app_flutter/common/components/base_divider/a_divider_private.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextContentHorizontal extends StatelessWidget {
  /// Khai báo nội dung [title]
  final String? title;

  /// Khai báo nội dung [content]
  final String? content;

  /// Khai báo style chung của [title]
  final TextStyle? titleStyle;

  /// Khai báo style chung của [content]
  final TextStyle? contentStyle;

  /// Kiểm tra xem có hiển thị đường kẻ không [divider]
  final bool isShowDivider;

  ///Kiểm tra xem có hiển thị [content] hay không
  final bool isShowContent;

  const TextContentHorizontal({
    super.key,
    this.title,
    this.content,
    this.titleStyle,
    this.contentStyle,
    this.isShowDivider = true,
    this.isShowContent = true,
  });

  /// Hiển thị nội dung và đường kẻ , với kích thước [textStyle] [fontSize = 14.sp , fontWeight = FontWeight(500),]
  TextContentHorizontal.bodyTittle4({super.key, this.title, this.content})
      : isShowDivider = true,
        isShowContent = true,
        titleStyle = CommonTextStyle.bodyB4.copyWith(
          color: CommonColors.secondaryColor1,
        ),
        contentStyle = CommonTextStyle.bodyB4;

  /// Hiển thị nội dung và đường kẻ , với kích thước [textStyle] [fontSize = 12.sp , fontWeight = FontWeight(500),]
  TextContentHorizontal.scriptSubtitle1({super.key, this.title, this.content})
      : isShowDivider = true,
        isShowContent = true,
        titleStyle = CommonTextStyle.scriptSubtitle1.copyWith(
          color: CommonColors.secondaryColor1,
        ),
        contentStyle = CommonTextStyle.scriptSubtitle1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRowContent(),
          if (isShowDivider)
            Padding(
              padding: EdgeInsets.only(top: 12.s),
              child: CustomDivider(
                configs: const ADividerConfigs(
                  type: ADividerType.line,
                  color: CommonColors.secondaryColor3,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRowContent() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title ?? "Title",
            style: titleStyle,
          ),
        ),
        if (isShowContent)
          Expanded(
            flex: 1,
            child: Text(
              content ?? 'Content',
              textAlign: TextAlign.right,
              style: contentStyle,
            ),
          ),
      ],
    );
  }
}
