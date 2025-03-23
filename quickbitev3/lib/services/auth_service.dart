import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;

  // For demo purposes, we'll simulate authentication
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo, accept any non-empty email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: email,
        phone: '+234 812 345 6789',
        profilePicture: 'https://randomuser.me/api/portraits/men/32.jpg',
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo, accept any non-empty values
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: '1',
        name: name,
        email: email,
        phone: null,
        profilePicture: null,
      );
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }
    
    return false;
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<User?> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // For demo, return a mock user if authenticated
    if (_isAuthenticated && _currentUser != null) {
      return _currentUser;
    } else {
      // For demo purposes, create a mock user
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+234 812 345 6789',
        profilePicture: 'https://randomuser.me/api/portraits/men/32.jpg',
      );
      _isAuthenticated = true;
      return _currentUser;
    }
  }

  Future<bool> updateProfile(User updatedUser) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _currentUser = updatedUser;
    notifyListeners();
    return true;
  }
}