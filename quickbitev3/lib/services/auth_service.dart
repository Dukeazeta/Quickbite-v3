import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;

  // Initialize the service by loading saved user data
  Future<void> initialize() async {
    await _loadUserFromStorage();
  }

  // Load user data from local storage
  Future<void> _loadUserFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');
      
      if (userData != null) {
        final userMap = json.decode(userData) as Map<String, dynamic>;
        _currentUser = User.fromJson(userMap);
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  // Save user data to local storage
  Future<void> _saveUserToStorage(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', json.encode(user.toJson()));
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

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
        profilePicture: 'assets/svg/default_profile.svg', // Changed to SVG asset
        favoriteItems: [],
        favoriteRestaurants: [],
      );
      _isAuthenticated = true;
      
      // Save to storage
      await _saveUserToStorage(_currentUser!);
      
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
        favoriteItems: [],
        favoriteRestaurants: [],
      );
      _isAuthenticated = true;
      
      // Save to storage
      await _saveUserToStorage(_currentUser!);
      
      notifyListeners();
      return true;
    }
    
    return false;
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Clear stored user data
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    
    _currentUser = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Update the getCurrentUser method to use a local asset instead of randomuser.me
  // Update the getCurrentUser method to use SVG
  Future<User?> getCurrentUser() async {
    // If we already have a user, return it
    if (_isAuthenticated && _currentUser != null) {
      return _currentUser;
    }
    
    // Try to load from storage
    await _loadUserFromStorage();
    
    // If still no user, create a mock one for demo
    if (!_isAuthenticated || _currentUser == null) {
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+234 812 345 6789',
        profilePicture: 'assets/svg/default_profile.svg', // Changed to SVG asset
        favoriteItems: [],
        favoriteRestaurants: [],
      );
      _isAuthenticated = true;
      
      // Save to storage
      await _saveUserToStorage(_currentUser!);
      
      notifyListeners();
    }
    
    return _currentUser;
  }
  
  // Remove the duplicate login method that was here
  Future<bool> updateProfile(User updatedUser) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    _currentUser = updatedUser;
    
    // Save to storage
    await _saveUserToStorage(_currentUser!);
    
    notifyListeners();
    return true;
  }

  Future<bool> toggleFavoriteItem(String itemId) async {
    if (_currentUser == null) return false;
    
    List<String> favorites = _currentUser!.favoriteItems?.toList() ?? [];
    
    if (favorites.contains(itemId)) {
      favorites.remove(itemId);
    } else {
      favorites.add(itemId);
    }
    
    _currentUser = _currentUser!.copyWith(favoriteItems: favorites);
    
    // Save to storage
    await _saveUserToStorage(_currentUser!);
    
    notifyListeners();
    return true;
  }

  Future<bool> toggleFavoriteRestaurant(String restaurantId) async {
    if (_currentUser == null) return false;
    
    List<String> favorites = _currentUser!.favoriteRestaurants?.toList() ?? [];
    
    if (favorites.contains(restaurantId)) {
      favorites.remove(restaurantId);
    } else {
      favorites.add(restaurantId);
    }
    
    _currentUser = _currentUser!.copyWith(favoriteRestaurants: favorites);
    
    // Save to storage
    await _saveUserToStorage(_currentUser!);
    
    notifyListeners();
    return true;
  }

  bool isFavoriteItem(String itemId) {
    return _currentUser?.favoriteItems?.contains(itemId) ?? false;
  }

  bool isFavoriteRestaurant(String restaurantId) {
    return _currentUser?.favoriteRestaurants?.contains(restaurantId) ?? false;
  }
}