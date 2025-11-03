import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isAdmin = false;
  String _userName = '';

  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _isAdmin;
  String get userName => _userName;

  void login(String email, String password) {
    // Mock authentication - in real app, this would call API
    if (email == 'admin@example.com' && password == 'admin123') {
      _isLoggedIn = true;
      _isAdmin = true;
      _userName = 'مدیر';
    } else if (email == 'user@example.com' && password == 'user123') {
      _isLoggedIn = true;
      _isAdmin = false;
      _userName = 'کارشناس محلی';
    }
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _isAdmin = false;
    _userName = '';
    notifyListeners();
  }
}