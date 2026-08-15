import 'package:flutter/material.dart';

class BentoCardViewModel extends ChangeNotifier {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get isHovered => _isHovered;
  bool get isPressed => _isPressed;

  void setHovered(bool value) {
    if (_isHovered != value) {
      _isHovered = value;
      notifyListeners();
    }
  }

  void setPressed(bool value) {
    if (_isPressed != value) {
      _isPressed = value;
      notifyListeners();
    }
  }
}
