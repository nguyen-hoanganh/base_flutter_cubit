import 'dart:math';

import 'package:cbp_mobile_app_flutter/common/components/button/touchable_opacity/touchable_opacity.dart';
import 'package:cbp_mobile_app_flutter/common/components/input/input_form/model/input_form_configs.dart';
import 'package:cbp_mobile_app_flutter/common/components/keyboard_visibility_listener/keyboard_visibility_notifier.dart';
import 'package:cbp_mobile_app_flutter/common/extensions/string_ext.dart';
import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:cbp_mobile_app_flutter/common/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

export 'model/input_form_configs.dart';
part 'widgets/error_caption_widget.dart';
part 'widgets/prefix_widget.dart';
part 'widgets/suffix_widget.dart';

class InputForm extends StatefulWidget {
  final InputFormConfigs configs;

  InputForm({
    Key? key,
    required InputFormConfigs configs,
  })  : configs = setDefaultValuesToConfigs(configs),
        super(key: key);

  static InputFormConfigs setDefaultValuesToConfigs(
    InputFormConfigs inputConfigs,
  ) {
    final textStyle = inputConfigs.textStyle ??
        CommonTextStyle.bodyB4.copyWith(
          color: inputConfigs.inputType == InputType.inputNormal ||
                  inputConfigs.inputType == InputType.inputAmount
              ? CommonColors.primaryColor1
              : CommonColors.neutralColor2,
        );
    final hintTextStyle =
        inputConfigs.hintTextStyle ?? CommonTextStyle.scriptSubtitle1;
    final labelTextStyle =
        inputConfigs.labelTextStyle ?? CommonTextStyle.scriptSubtitle1;
    final floatingLabelTextStyle =
        inputConfigs.floatingLabelTextStyle ?? CommonTextStyle.scriptSubtitle1;
    final errorTextStyle = inputConfigs.errorTextStyle ??
        CommonTextStyle.scriptSubtitle1.copyWith(
          color: CommonColors.accentColor2,
        );
    final captionTextStyle =
        inputConfigs.captionTextStyle ?? CommonTextStyle.scriptSubtitle1;

    final errorPadding = inputConfigs.errorPadding ?? EdgeInsets.only(top: 4.s);
    final captionPadding =
        inputConfigs.captionPadding ?? EdgeInsets.only(top: 4.s);

    return inputConfigs.copyWith(
      padding: inputConfigs.padding ??
          EdgeInsets.symmetric(
            horizontal: 16.s,
            vertical: 12.s,
          ),
      errorPadding: errorPadding,
      captionPadding: captionPadding,
      textStyle: textStyle,
      hintTextStyle: hintTextStyle,
      labelTextStyle: labelTextStyle,
      floatingLabelTextStyle: floatingLabelTextStyle,
      errorTextStyle: errorTextStyle,
      captionTextStyle: captionTextStyle,
      boxBorder: inputConfigs.boxBorder ??
          Border.all(
            color: inputConfigs.hasError
                ? CommonColors.accentColor2
                : CommonColors.secondaryColor3,
          ),
      borderRadius: inputConfigs.borderRadius ?? BorderRadius.circular(6),
      // backgroundGradientColor: inputConfigs.backgroundGradientColor ??
      //     themeData.color.surfaceNeutralSub,
      cursorColor: inputConfigs.cursorColor ?? CommonColors.primaryColor1,
      layerAboveShadowColor:
          inputConfigs.layerAboveShadowColor ?? CommonColors.neutralColor7,
      keyboardType: inputConfigs.keyboardType ??
          _getNumberType(
            inputConfigs,
          ),
      inputFormatters: inputConfigs.inputFormatters ??
          _getInputFormatters(
            inputConfigs,
          ),
      currency: _getCurrency(
        inputConfigs,
      ),
    );
  }

  static String? _getCurrency(InputFormConfigs passedConfigs) {
    if (!passedConfigs.currency.isNullOrEmptyString &&
        (passedConfigs.numberType == InputNumberType.decimal ||
            passedConfigs.numberType == InputNumberType.digitsOnly)) {
      return "${passedConfigs.currency} ";
    }
    return "";
  }

  static TextInputType? _getNumberType(InputFormConfigs passedConfigs) {
    switch (passedConfigs.numberType) {
      case InputNumberType.digitsOnly:
        return TextInputType.number;
      case InputNumberType.decimal:
        return const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        );
      default:
        return null;
    }
  }

  static List<TextInputFormatter>? _getInputFormatters(
    InputFormConfigs passedConfigs,
  ) {
    switch (passedConfigs.numberType) {
      case InputNumberType.decimal:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
          _CurrencyInputDecimalFormatter(),
          ...passedConfigs.inputFormatters ?? [],
        ];
      case InputNumberType.digitsOnly:
        return [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\,]')),
          _CurrencyInputDigitFormatter(),
          ...passedConfigs.inputFormatters ?? [],
        ];
      default:
        return null;
    }
  }

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey captionTextKey = GlobalKey();
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
      opacity: widget.configs.enabled
          ? 1
          : widget.configs.opacityWhenDisabled
              ? 0.6
              : 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: widget.configs.layerAboveShadowColor,
              borderRadius: widget.configs.borderRadius,
              boxShadow: widget.configs.boxShadow,
              border: widget.configs.boxBorder,
            ),
            child: TouchableOpacity(
              onTap: widget.configs.enabled ? widget.configs.onTap : null,
              disabled: !widget.configs.enabled || widget.configs.onTap == null,
              opacityWhenDisabled: false,
              child: Padding(
                padding: widget.configs.padding ?? EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: widget.configs.controller,
                        cursorWidth: widget.configs.cursorWidth ?? 2,
                        cursorHeight: widget.configs.cursorHeight,
                        cursorColor: widget.configs.cursorColor,
                        focusNode: widget.configs.focusNode,
                        keyboardType: widget.configs.keyboardType,
                        enabled:
                            widget.configs.enabled && widget.configs.editable,
                        obscureText: widget.configs.isObscureText,
                        initialValue: widget.configs.controller != null
                            ? null
                            : widget.configs.initialValue,
                        obscuringCharacter: "●",
                        style: widget.configs.textStyle,
                        minLines: 1,
                        maxLines: widget.configs.textMaxLines,
                        maxLength: widget.configs.textMaxLength,
                        textInputAction: widget.configs.textInputAction,
                        maxLengthEnforcement:
                            widget.configs.maxLengthEnforcement,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          labelText: widget.configs.labelText,
                          labelStyle: widget.configs.labelTextStyle,
                          floatingLabelStyle:
                              widget.configs.floatingLabelTextStyle,
                          isDense: true,
                          prefixText: widget.configs.currency,
                          prefixStyle: widget.configs.textStyle,
                          prefixIcon: _PrefixWidget(configs: widget.configs),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          counterText: "",
                          hintText: widget.configs.hintText,
                          hintStyle: widget.configs.hintTextStyle,
                        ),
                        inputFormatters: widget.configs.inputFormatters,
                        onChanged: (value) async {
                          // await Scrollable.ensureVisible(
                          //   captionTextKey.currentContext ?? context,
                          //   duration: const Duration(milliseconds: 500),
                          //   alignmentPolicy:
                          //       ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                          //   curve: Curves.easeInOut,
                          // );
                          widget.configs.onChanged?.call(value);
                          _isDirty = true;
                        },
                        onEditingComplete: widget.configs.onEditingComplete,
                        onFieldSubmitted: widget.configs.onFieldSubmitted,
                        onSaved: widget.configs.onSaved,
                        validator: widget.configs.validator,
                        autovalidateMode: widget.configs.autovalidateMode,
                        textCapitalization: widget.configs.textCapitalization ??
                            TextCapitalization.none,
                        autofocus: widget.configs.autofocus,
                        textAlign: widget.configs.textAlign ?? TextAlign.start,
                      ),
                    ),
                    _SuffixWidget(configs: widget.configs),
                  ],
                ),
              ),
            ),
          ),
          _ErrorCaptionWidget(configs: widget.configs),
        ],
      ),
    );
  }
}

class _CurrencyInputDigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final baseOffset = newValue.selection.baseOffset;
    final formattedText = newValue.text.moneyFormatNomal;

    final additionalOffset =
        (baseOffset < 3) ? 0 : ((baseOffset - 1) / 3).floor();
    final offset = min(formattedText.length, baseOffset + additionalOffset);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText == "0" ? 1 : offset,
      ),
    );
  }
}

class _CurrencyInputDecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // final baseOffset = newValue.selection.baseOffset;
    final formattedText = moneyFormatInputDecimal(
      value: newValue.text,
    );
    // int additionalOffset =
    //     (baseOffset < 3) ? 0 : ((baseOffset - 1) / 3).floor();
    // if (newValue.text.contains(".")) additionalOffset += 1;
    // final offset = min(formattedText.length, baseOffset + additionalOffset);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(
        // offset: formattedText == "0" ? 1 : offset,
        offset: formattedText.length,
      ),
    );
  }

  String moneyFormatInputDecimal({
    required String value,
    int? decimal,
  }) {
    const defaultReturnValue = "0";
    if (value.isEmpty) return defaultReturnValue;

    final splittedStrValue = value.split(".");
    if (splittedStrValue.isEmpty) return value.moneyFormatNomal;
    String result = splittedStrValue[0].moneyFormatNomal;
    if (splittedStrValue.length == 2) {
      final end = min(splittedStrValue[1].length, 2);
      result += ".${splittedStrValue[1].substring(0, end)}";
    }

    return result;
  }
}
