import 'dart:async';
import 'dart:ui';

class DebouncerFunc {
  final Duration delay;
  VoidCallback? action;
  Timer? _timer;

  DebouncerFunc({required this.delay});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(delay, action);
  }
}