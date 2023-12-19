import 'package:cbp_mobile_app_flutter/common/components/keyboard_visibility_listener/keyboard_visibility_notifier.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

part 'model/normal_input_configs.dart';
part 'widget/error_caption_widget.dart';

class NormalInput extends StatefulWidget {
  final NormalInputConfigs configs;

  const NormalInput({
    super.key,
    required this.configs,
  });

  @override
  State<NormalInput> createState() => _NormalInputState();
}

class _NormalInputState extends State<NormalInput> {
  KeyboardNotifier? keyboardNotifier;
  late bool _isDirty = widget.configs.triggerKeyboardListenerWhenFirstBuild;

  @override
  void initState() {
    super.initState();
    if (widget.configs.onKeyboardShowHide != null) {
      keyboardNotifier = KeyboardNotifier();
      keyboardNotifier?.addListener((isKeyboardVisible) {
        if (_isDirty) {
          if (isKeyboardVisible &&
              widget.configs.focusNode?.hasFocus != false) {
            widget.configs.onKeyboardShowHide?.call(true);
          } else if (!isKeyboardVisible) {
            widget.configs.onKeyboardShowHide?.call(false);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    keyboardNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.configs.enabled || !widget.configs.opacityWhenDisabled
          ? 1
          : 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: widget.configs.padding ??
                EdgeInsets.symmetric(horizontal: 12.s, vertical: 5.s),
            decoration: BoxDecoration(
              border: widget.configs.hasError
                  ? widget.configs.errorBorder$
                  : widget.configs.border$,
              borderRadius: BorderRadius.circular(5.s),
              color: CommonColors.neutralColor7,
            ),
            child: TextFormField(
              controller: widget.configs.controller,
              cursorWidth: widget.configs.cursorWidth ?? 2,
              cursorHeight: widget.configs.cursorHeight,
              cursorColor: widget.configs.cursorColor,
              focusNode: widget.configs.focusNode,
              keyboardType: widget.configs.keyboardType,
              enabled: widget.configs.enabled && widget.configs.editable,
              obscureText: widget.configs.isObscureText,
              initialValue: widget.configs.controller != null
                  ? null
                  : widget.configs.initialValue,
              style: widget.configs.textStyle ??
                  CommonTextStyle.supportFontSubtitle1.copyWith(height: 1.2),
              minLines: 1,
              maxLines: widget.configs.textMaxLines,
              maxLength: widget.configs.textMaxLength,
              textInputAction: widget.configs.textInputAction,
              maxLengthEnforcement: widget.configs.maxLengthEnforcement,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 5.s),
                prefixIconConstraints: widget.configs.prefixIcon != null
                    ? widget.configs.iconBoxConstraints$
                    : null,
                prefixIcon: widget.configs.prefixIcon != null
                    ? GestureDetector(
                        onTap: widget.configs.onPrefixIconTap,
                        child: SizedBox(
                          width: 24.s,
                          height: 24.s,
                          child: Center(child: widget.configs.prefixIcon),
                        ),
                      )
                    : null,
                suffixIconConstraints: widget.configs.suffixIcon != null
                    ? widget.configs.iconBoxConstraints$
                    : null,
                suffixIcon: widget.configs.suffixIcon != null
                    ? GestureDetector(
                        onTap: widget.configs.onSuffixIconTap,
                        child: SizedBox(
                          width: 24.s,
                          height: 24.s,
                          child: Center(child: widget.configs.suffixIcon),
                        ),
                      )
                    : null,
                hintStyle:
                    widget.configs.hintTextStyle ?? widget.configs.labelStyle$,
                labelStyle:
                    widget.configs.labelTextStyle ?? widget.configs.labelStyle$,
                hintText: widget.configs.hintText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                floatingLabelStyle: widget.configs.floatingLabelTextStyle ??
                    widget.configs.labelStyle$.copyWith(fontSize: 18.s),
                border: InputBorder.none,
                labelText: widget.configs.labelText,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              inputFormatters: widget.configs.inputFormatters,
              onChanged: (value) {
                widget.configs.onChanged?.call(value);
                _isDirty = true;
              },
              onEditingComplete: widget.configs.onEditingComplete,
              onFieldSubmitted: widget.configs.onFieldSubmitted,
              onSaved: widget.configs.onSaved,
              validator: widget.configs.validator,
              autovalidateMode: widget.configs.autovalidateMode,
              textCapitalization:
                  widget.configs.textCapitalization ?? TextCapitalization.none,
              autofocus: widget.configs.autofocus,
              textAlign: widget.configs.textAlign ?? TextAlign.start,
            ),
          ),
          _ErrorCaptionWidget(configs: widget.configs),
        ],
      ),
    );
  }
}
