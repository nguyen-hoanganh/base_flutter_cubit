part of '../modal_bottom.dart';

class ModalBottomDragableConfigs {
  final Widget Function(
    BuildContext context,
    ScrollController scrollController,
  )? bodyBuilder;
  final bool? hasSafeAreaTop;

  final double? _maxSizePercent;
  final double? _initSizePercent;
  final double? _minSizePercent;

  ModalBottomDragableConfigs({
    this.bodyBuilder,
    double? maxSizePercent = 100,
    double? initSizePercent = 50,
    double? minSizePercent = 50,
    this.hasSafeAreaTop,
  })  : _maxSizePercent = maxSizePercent,
        _initSizePercent = initSizePercent,
        _minSizePercent = minSizePercent;

  double getMaxSize(BuildContext context) =>
      _convertPercentToSizeValue(context, _maxSizePercent$);
  double getMinSize(BuildContext context) =>
      _convertPercentToSizeValue(context, _minSizePercent$);
  double getInitSize(BuildContext context) {
    final maxSize = getMaxSize(context);
    final minSize = getMinSize(context);
    final initSize = _convertPercentToSizeValue(context, _initSizePercent$);

    return min(max(minSize, initSize), maxSize);
  }

  double _convertPercentToSizeValue(
    BuildContext context,
    double? sizePercent,
  ) {
    if (sizePercent == null || sizePercent < 10) return 0.1;

    final screenContext = context;
    // Modular.routerDelegate.navigatorKey.currentContext ?? context;

    final mediaQuery = MediaQuery.of(screenContext);
    final screenHeight = mediaQuery.size.height;
    final safeAreaPaddingTop = hasSafeAreaTop$ ? mediaQuery.padding.top : 0;
    final maxSize = (screenHeight - safeAreaPaddingTop) / screenHeight;
    var result = sizePercent / 100;

    result = result > maxSize ? maxSize : result;

    return min(
      result + mediaQuery.viewInsets.bottom / screenHeight,
      maxSize,
    );
  }

  ModalBottomDragableConfigs copyWith({
    Widget Function(
      BuildContext context,
      ScrollController scrollController,
    )?
        bodyBuilder,
    double? maxSizePercent,
    double? initSizePercent,
    double? minSizePercent,
    bool? hasSafeAreaTop,
  }) {
    return ModalBottomDragableConfigs(
      bodyBuilder: bodyBuilder ?? this.bodyBuilder,
      maxSizePercent: maxSizePercent ?? _maxSizePercent,
      initSizePercent: initSizePercent ?? _initSizePercent,
      minSizePercent: minSizePercent ?? _minSizePercent,
      hasSafeAreaTop: hasSafeAreaTop ?? this.hasSafeAreaTop,
    );
  }

  bool get hasSafeAreaTop$ => hasSafeAreaTop ?? true;
  double get _maxSizePercent$ => _maxSizePercent ?? 100;
  double get _initSizePercent$ => _initSizePercent ?? 50;
  double get _minSizePercent$ => _minSizePercent ?? 50;
}
