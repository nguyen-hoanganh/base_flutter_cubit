import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
part 'models/toggle_configs.dart';

class ToggleButton extends StatefulWidget {
  final ToggleConfigs configs;

  const ToggleButton({Key? key, required this.configs}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  double _size = 30.s;
  late double _innerPadding;

  @override
  void initState() {
    super.initState();
    _size = widget.configs.sizes ?? 30.s;
    _innerPadding = _size / 10;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => widget.configs.value = !widget.configs.value$);
        widget.configs.onChange?.call(widget.configs.value$);
      },
      onPanEnd: (b) {
        setState(() => widget.configs.value = !widget.configs.value$);
        widget.configs.onChange?.call(widget.configs.value$);
      },
      child: AnimatedContainer(
        height: _size,
        width: _size * 2,
        padding: EdgeInsets.all(_innerPadding),
        alignment: widget.configs.value$
            ? Alignment.centerRight
            : Alignment.centerLeft,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.s),
          color: widget.configs.value$
              ? CommonColors.secondaryColor2
              : CommonColors.neutralColor5,
        ),
        child: Container(
          width: _size - _innerPadding * 2,
          height: _size - _innerPadding * 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CommonColors.neutralColor7,
          ),
        ),
      ),
    );
  }
}
