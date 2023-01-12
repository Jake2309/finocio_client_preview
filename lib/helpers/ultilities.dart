import 'dart:async';
import 'dart:ui';

// Ham delay miliseconds sau do moi thuc hien
// - phuc vu search khi user type xong 500ms moi triggerr search

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  late Timer _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  cancel() {
    _timer.cancel();
  }
}
