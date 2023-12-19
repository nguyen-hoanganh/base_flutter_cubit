part of '../check_box_button.dart';

class CheckBoxConfigs {
  bool? value;
  final Function(bool valueChange)? onChange;

  CheckBoxConfigs({
    this.value,
    this.onChange,
  });

  CheckBoxConfigs copyWith({
    bool? value,
    Function(bool valueChange)? onChange,
    Color? activeColor,
    Color? checkColor,
    BorderSide? side,
  }) {
    return CheckBoxConfigs(
      value: value ?? this.value,
      onChange: onChange ?? this.onChange,
    );
  }

  bool get value$ => value ?? false;
}
