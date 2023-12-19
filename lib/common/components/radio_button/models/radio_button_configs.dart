part of '../radio_button.dart';

class RadioButtonConfigs {
  final double? width;
  final double? height;
  bool? value;
  bool? isDisabled;
  final Function(bool value)? onChange;

  RadioButtonConfigs({
    this.height,
    this.width,
    this.value,
    this.isDisabled,
    this.onChange,
  });

  RadioButtonConfigs copyWith({
    final double? width,
    final double? height,
    bool? value,
    bool? isDisabled,
    Function(bool value)? onChange,
  }) {
    return RadioButtonConfigs(
      width: width ?? this.width,
      height: height ?? this.height,
      value: value ?? this.value,
      isDisabled: isDisabled ?? this.isDisabled,
      onChange: onChange ?? this.onChange,
    );
  }

  bool get value$ => value ?? false;
}
