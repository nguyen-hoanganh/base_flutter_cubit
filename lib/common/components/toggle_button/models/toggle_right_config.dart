class ToggleRightConfig {
  final String? text;
  bool? isShowBackground;
  bool value;
  final Function(bool value)? onChange;

  ToggleRightConfig({
    this.text,
    this.isShowBackground,
    this.onChange,
    required this.value,
  });

  ToggleRightConfig copyWith({
    String? text,
    bool? isShowBackground,
    Function(bool value)? onChange,
    bool? value,
  }) {
    return ToggleRightConfig(
      text: text ?? this.text,
      isShowBackground: isShowBackground ?? this.isShowBackground,
      onChange: onChange ?? this.onChange,
      value: value ?? this.value,
    );
  }

  bool get isShowBackground$ => isShowBackground ?? false;
  bool get value$ => value;

  String get text$ => text ?? '';
}
