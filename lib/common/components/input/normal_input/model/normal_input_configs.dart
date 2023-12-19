part of '../normal_input.dart';

class NormalInputConfigs {
  final TextEditingController? controller;

  final bool enabled;
  final bool editable;
  final bool isObscureText;
  final bool canTapSuffixOnDisable;
  final bool opacityWhenDisabled;
  final bool autofocus;

  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? captionText;

  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? floatingLabelTextStyle;
  final TextStyle? errorTextStyle;
  final TextStyle? captionTextStyle;

  final List<TextInputFormatter>? inputFormatters;

  final int? textMaxLines;
  final int? textMaxLength;
  final int? textMinLines;
  final int errorMaxLines;
  final int captionMaxLines;

  final EdgeInsets? padding;
  final EdgeInsets? errorPadding;
  final EdgeInsets? captionPadding;

  final Widget? suffixIcon;
  final Function()? onSuffixIconTap;

  final Widget? prefixIcon;
  final Function()? onPrefixIconTap;

  final LinearGradient? backgroundGradientColor;
  final Color? layerAboveShadowColor;
  final List<BoxShadow>? boxShadow;

  final BorderRadius? borderRadius;
  final BoxBorder? boxBorder;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final MaxLengthEnforcement? maxLengthEnforcement;

  final double? cursorHeight;
  final double? cursorWidth;
  final Color? cursorColor;

  final Function()? onTap;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  final Function(String? value)? onSaved;
  final FormFieldValidator<String>? validator;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final AutovalidateMode? autovalidateMode;

  bool get hasError => errorText?.isNotEmpty == true;

  final void Function(bool isShowing)? onKeyboardShowHide;
  final bool triggerKeyboardListenerWhenFirstBuild;

  const NormalInputConfigs({
    this.controller,
    this.enabled = true,
    this.editable = true,
    this.isObscureText = false,
    this.canTapSuffixOnDisable = false,
    this.opacityWhenDisabled = true,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.errorText,
    this.captionText,
    this.textStyle,
    this.textAlign,
    this.hintTextStyle,
    this.labelTextStyle,
    this.floatingLabelTextStyle,
    this.errorTextStyle,
    this.captionTextStyle,
    this.inputFormatters,
    this.textMaxLines = 1,
    this.textMaxLength,
    this.errorMaxLines = 5,
    this.captionMaxLines = 5,
    this.textMinLines,
    this.padding,
    this.errorPadding,
    this.captionPadding,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.backgroundGradientColor,
    this.layerAboveShadowColor,
    this.boxShadow,
    this.borderRadius,
    this.boxBorder,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.maxLengthEnforcement,
    this.cursorHeight,
    this.cursorWidth,
    this.cursorColor,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.textCapitalization,
    this.autofocus = false,

    /// A callback when the Keyboard is showing or hiding
    ///
    /// On Android, the Keyboard can be hiden without losing focus of the TextField,
    ///
    /// so if you want to validate when the TextField is lost focus, use this callback instead
    this.onKeyboardShowHide,
    this.triggerKeyboardListenerWhenFirstBuild = false,
    this.autovalidateMode,
  });

  NormalInputConfigs copyWith({
    TextEditingController? controller,
    bool? enabled,
    bool? editable,
    bool? isObscureText,
    bool? canTapSuffixOnDisable,
    bool? opacityWhenDisabled,
    bool? autofocus,
    String? initialValue,
    String? hintText,
    String? labelText,
    String? errorText,
    String? captionText,
    TextStyle? textStyle,
    TextStyle? hintTextStyle,
    TextStyle? labelTextStyle,
    TextStyle? floatingLabelTextStyle,
    TextStyle? errorTextStyle,
    TextStyle? captionTextStyle,
    List<TextInputFormatter>? inputFormatters,
    int? textMaxLines,
    int? textMaxLength,
    int? errorMaxLines,
    int? captionMaxLines,
    int? textMinLines,
    EdgeInsets? padding,
    EdgeInsets? errorPadding,
    EdgeInsets? captionPadding,
    Widget? suffixIcon,
    Function()? onSuffixIconTap,
    Widget? prefixIcon,
    Function()? onPrefixIconTap,
    LinearGradient? backgroundGradientColor,
    Color? layerAboveShadowColor,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    BoxBorder? boxBorder,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    MaxLengthEnforcement? maxLengthEnforcement,
    double? cursorHeight,
    double? cursorWidth,
    Color? cursorColor,
    Function()? onTap,
    Function(String value)? onChanged,
    Function()? onEditingComplete,
    Function(String value)? onFieldSubmitted,
    Function(String? value)? onSaved,
    FormFieldValidator<String>? validator,
    TextCapitalization? textCapitalization,
    TextAlign? textAlign,
    void Function(bool isShowing)? onKeyboardShowHide,
    bool? triggerKeyboardListenerWhenFirstBuild,
    AutovalidateMode? autovalidateMode,
  }) {
    return NormalInputConfigs(
      controller: controller ?? this.controller,
      enabled: enabled ?? this.enabled,
      editable: editable ?? this.editable,
      isObscureText: isObscureText ?? this.isObscureText,
      canTapSuffixOnDisable:
          canTapSuffixOnDisable ?? this.canTapSuffixOnDisable,
      opacityWhenDisabled: opacityWhenDisabled ?? this.opacityWhenDisabled,
      autofocus: autofocus ?? this.autofocus,
      initialValue: initialValue ?? this.initialValue,
      hintText: hintText ?? this.hintText,
      labelText: labelText ?? this.labelText,
      errorText: errorText ?? this.errorText,
      captionText: captionText ?? this.captionText,
      textStyle: textStyle ?? this.textStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      floatingLabelTextStyle:
          floatingLabelTextStyle ?? this.floatingLabelTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      captionTextStyle: captionTextStyle ?? this.captionTextStyle,
      inputFormatters: inputFormatters ?? this.inputFormatters,
      textMaxLines: textMaxLines ?? this.textMaxLines,
      textMaxLength: textMaxLength ?? this.textMaxLength,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      captionMaxLines: captionMaxLines ?? this.captionMaxLines,
      textMinLines: textMinLines ?? this.textMinLines,
      padding: padding ?? this.padding,
      errorPadding: errorPadding ?? this.errorPadding,
      captionPadding: captionPadding ?? this.captionPadding,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      onSuffixIconTap: onSuffixIconTap ?? this.onSuffixIconTap,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      onPrefixIconTap: onPrefixIconTap ?? this.onPrefixIconTap,
      backgroundGradientColor:
          backgroundGradientColor ?? this.backgroundGradientColor,
      layerAboveShadowColor:
          layerAboveShadowColor ?? this.layerAboveShadowColor,
      boxShadow: boxShadow ?? this.boxShadow,
      borderRadius: borderRadius ?? this.borderRadius,
      boxBorder: boxBorder ?? this.boxBorder,
      focusNode: focusNode ?? this.focusNode,
      textInputAction: textInputAction ?? this.textInputAction,
      keyboardType: keyboardType ?? this.keyboardType,
      maxLengthEnforcement: maxLengthEnforcement ?? this.maxLengthEnforcement,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorColor: cursorColor ?? this.cursorColor,
      onTap: onTap ?? this.onTap,
      onChanged: onChanged ?? this.onChanged,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      onFieldSubmitted: onFieldSubmitted ?? this.onFieldSubmitted,
      onSaved: onSaved ?? this.onSaved,
      validator: validator ?? this.validator,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textAlign: textAlign ?? this.textAlign,
      onKeyboardShowHide: onKeyboardShowHide ?? this.onKeyboardShowHide,
      triggerKeyboardListenerWhenFirstBuild:
          triggerKeyboardListenerWhenFirstBuild ??
              this.triggerKeyboardListenerWhenFirstBuild,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }

  BoxBorder get border$ =>
      boxBorder ?? Border.all(color: CommonColors.secondaryColor5, width: 1.s);

  BoxConstraints get iconBoxConstraints$ => BoxConstraints(
        maxWidth: 32.s,
        maxHeight: 24.s,
        minWidth: 32.s,
      );

  BoxBorder get errorBorder$ =>
      Border.all(color: CommonColors.accentColor2, width: 1.s);

  TextStyle get labelStyle$ => CommonTextStyle.bodyB4.copyWith(height: 1.2);
}
