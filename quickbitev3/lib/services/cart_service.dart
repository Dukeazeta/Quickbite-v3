import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  
  List<Map<String, dynamic>> get items => _items;
  
  CartService() {
    _loadCartItems();
  }
  
  // Load cart items from SharedPreferences
  Future<void> _loadCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartData = prefs.getString('cart_items');
      
      if (cartData != null) {
        final List<dynamic> decodedData = jsonDecode(cartData);
        _items = decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }
  
  // Save cart items to SharedPreferences
  Future<void> _saveCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(_items);
      await prefs.setString('cart_items', encodedData);
    } catch (e) {
      print('Error saving cart items: $e');
    }
  }
  
  void addItem(Map<String, dynamic> item) {
    // Check if item already exists in cart
    final existingIndex = _items.indexWhere((i) => i['id'] == item['id']);
    
    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex]['quantity'] = (_items[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      // Add new item with quantity 1
      final newItem = {...item, 'quantity': 1};
      _items.add(newItem);
    }
    
    _saveCartItems();
    notifyListeners();
  }
  
  void removeItem(String id) {
    _items.removeWhere((item) => item['id'] == id);
    _saveCartItems();
    notifyListeners();
  }
  
  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item['id'] == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index]['quantity'] = quantity;
      }
      _saveCartItems();
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items = [];
    _saveCartItems();
    notifyListeners();
  }
  
  double get totalAmount {
    return _items.fold(0, (sum, item) {
      return sum + ((item['price'] ?? 0) * (item['quantity'] ?? 1));
    });
  }
  
  double get deliveryFee {
    // You can implement dynamic delivery fee calculation here
    return _items.isEmpty ? 0 : 500;
  }
  
  double get total {
    return totalAmount + deliveryFee;
  }
  
  int get itemCount {
    int count = 0;
    for (var item in _items) {
      count += (item['quantity'] as int? ?? 1);
    }
    return count;
  }
}