import 'package:flutter/foundation.dart';
import 'package:tryhard_showcase/ui/toast/views/toast.dart';

abstract class ToastController {
  void setMessage(String message);

  void dispose();
}

class RealToastController implements ToastController {
  RealToastController() {
    _message.addListener(_show);
  }

  final ValueNotifier<String?> _message = ValueNotifier(null);

  @override
  void setMessage(String message) {
    _message.value = message;
  }

  void _show() async {
    if (_message.value != null) {
      await showServiceToast(_message.value!);
      _clear();
    }
  }

  void _clear() {
    _message.value = null;
  }

  @override
  void dispose() {
    _message.removeListener(_show);
  }
}
