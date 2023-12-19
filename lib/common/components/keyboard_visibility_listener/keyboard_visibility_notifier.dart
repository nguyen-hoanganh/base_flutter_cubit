import 'package:flutter/material.dart';

class KeyboardNotifier {
  KeyboardListenable notifier = KeyboardListenable();

  /// Use this class for listening when the keyboard is showing or hiding
  KeyboardNotifier();

  void addListener(Function(bool) listener) {
    notifier.addListener(() {
      listener(notifier.isKeyboardVisible);
    });
  }

  void dispose() {
    notifier.dispose();
  }
}

class KeyboardListenable with WidgetsBindingObserver, ChangeNotifier {
  KeyboardListenable() {
    WidgetsBinding.instance.addObserver(this);
  }

  bool _isKeyboardVisible = false;

  bool get isKeyboardVisible => _isKeyboardVisible;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final isCurrentKeyboardVisible = bottomInset > 0.0;
    if (isCurrentKeyboardVisible != _isKeyboardVisible) {
      _isKeyboardVisible = isCurrentKeyboardVisible;
      notifyListeners();
    }
  }
}
