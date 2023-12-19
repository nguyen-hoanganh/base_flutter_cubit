import 'dart:async';

class ShimmerManager {
  static ShimmerManager? _instance;

  static ShimmerManager get shared {
    _instance ??= ShimmerManager._internal();

    return _instance!;
  }

  ShimmerManager._internal() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(milliseconds: _intervalValue), (_) {
      _currentCount += _intervalValue;
      if (_currentCount >= duration * 10) _currentCount = 0;

      final oldIsAnimationForward = _isAnimationForward;
      _isAnimationForward = (_currentCount ~/ duration) % 2 == 0;

      if (oldIsAnimationForward != _isAnimationForward) {
        _sink.add(_isAnimationForward);
      }
    });
  }

  // Configs
  final int _speed = 2;
  final _step = 7;
  final _intervalValue = 100;
  int get duration => _intervalValue * _step * _speed;

  // Stream
  final StreamController<bool> _streamController = StreamController.broadcast();
  Stream<bool> get stream => _streamController.stream;
  StreamSink<bool> get _sink => _streamController.sink;

  // Opacity values
  double get maxOpacity => 1;
  double get minOpacity {
    double min = 1 - (0.1 * _step);
    if (min < 0) min = 0;
    if (min > maxOpacity) min = maxOpacity;

    return min;
  }

  double get currentOpacity {
    final offset = (_currentCount % duration) / _speed / _intervalValue;
    double result = _isAnimationForward
        ? maxOpacity - (0.1 * offset)
        : maxOpacity - (0.1 * _step) + (0.1 * offset);
    if (result < minOpacity) result = minOpacity;
    if (result > maxOpacity) result = maxOpacity;

    return result;
  }

  // Variables
  Timer? _timer;
  int _currentCount = 0;

  bool _isAnimationForward = true;
  bool get isAnimationForward => _isAnimationForward;
}
