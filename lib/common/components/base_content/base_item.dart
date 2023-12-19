import 'package:flutter/material.dart';

class BaseItem extends StatelessWidget {
  ///Khai báo số dòng được phép hiển thị
  final int maxLine;

  ///khai báo icon
  final double? sizeAvatar;

  ///khai báo vị trí icon
  final bool? leftIcon;

  ///khai báo widget con
  final Widget? childLeftIcon;

  final Widget? childRightIcon;

  final Decoration? decoration;

  final bool? twoIcon;

  final String? title;

  final String? content;

  const BaseItem({
    Key? key,
    // this.typeItem = TypeItem.text,
    this.maxLine = 1,
    this.sizeAvatar = 24,
    this.leftIcon = true,
    this.childLeftIcon,
    this.childRightIcon,
    this.decoration,
    this.title,
    this.content,
    this.twoIcon = false,
  }) : super(key: key);

  const BaseItem.textLine({
    super.key,
    this.sizeAvatar,
    this.childLeftIcon,
    this.childRightIcon,
    required this.maxLine,
    this.leftIcon,
    this.decoration,
    this.title,
    this.content,
    this.twoIcon,
  });

  const BaseItem.textWithIcon({
    super.key,
    this.sizeAvatar,
    this.childLeftIcon,
    this.childRightIcon,
    required this.maxLine,
    this.leftIcon = true,
    this.decoration,
    this.title,
    this.content,
    this.twoIcon,
  });

  @override
  Widget build(BuildContext context) {
    return twoIcon == false ? buildLine() : buildLineTwoIcon();
  }

  Widget buildLine() {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Row(
        children: [
          if (leftIcon == true) buildIcon(),
          buildText(),
          if (leftIcon == false) buildIcon(),
        ],
      ),
    );
  }

  Widget buildLineTwoIcon() {
    return Container(
      decoration: decoration,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (leftIcon == true) buildLeftIcon(),
                buildText(),
              ],
            ),
          ),
          buildRightIcon(),
        ],
      ),
    );
  }

  Widget buildIcon() {
    return Padding(
      padding: leftIcon == true
          ? const EdgeInsets.only(right: 16)
          : const EdgeInsets.only(left: 16),
      child: childRightIcon,
    );
  }

  Widget buildRightIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: childRightIcon,
    );
  }

  Widget buildLeftIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: childLeftIcon,
    );
  }

  Widget buildText() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (maxLine - 1 >= 0)
            Text(
              title ?? 'Title',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          if (maxLine != 1)
            Text(
              content ?? 'Content',
              maxLines: maxLine - 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
