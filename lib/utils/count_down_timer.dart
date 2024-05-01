import 'dart:async';

class CountdownTimer {
  StreamController<int>? _controller;
  Timer? _timer;
  int _currentSeconds = 0;
  bool _isPaused = false;

  Stream<int> countdownStream(int seconds) {
    _currentSeconds = seconds;
    _controller = StreamController<int>();

    void tick(_) {
      if (!_isPaused && _currentSeconds > 0) {
        _currentSeconds--;
        _controller?.add(_currentSeconds);
      } else if (_currentSeconds == 0) {
        _controller?.close();
        _timer?.cancel();
      }
    }

    _timer = Timer.periodic(const Duration(seconds: 1), tick);
    return _controller!.stream;
  }

  void pauseTimer() {
    _isPaused = true;
  }

  void resumeTimer() {
    _isPaused = false;
  }

  void stopTimer() {
    _isPaused = false;
    _controller?.close();
    _timer?.cancel();
  }
}
