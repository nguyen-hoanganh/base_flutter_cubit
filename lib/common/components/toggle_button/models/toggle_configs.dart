part of '../toggle_button.dart';

class ToggleConfigs {
  double? sizes;
  bool? value;
  final Function(bool value)? onChange;

  ToggleConfigs({
    this.sizes,
    this.value,
    this.onChange,
  });

  ToggleConfigs copyWith({
    double? sizes,
    bool? value,
    Function(bool value)? onChange,
  }) {
    return ToggleConfigs(
      sizes: sizes ?? this.sizes,
      value: value ?? this.value,
      onChange: onChange ?? this.onChange,
    );
  }

  bool get value$ => value ?? false;
}
