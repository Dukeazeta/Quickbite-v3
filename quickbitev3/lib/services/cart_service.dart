import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartService extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  
  List<Map<String, dynamic>> get items => _items;
  bool get isLoading => _isLoading;
  
  CartService() {
    _loadCartItems();
  }
  
  // Load cart items from SharedPreferences
  Future<void> _loadCartItems() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartData = prefs.getString('cart_items');
      
      if (cartData != null && cartData.isNotEmpty) {
        final List<dynamic> decodedData = jsonDecode(cartData);
        _items = decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
        if (kDebugMode) {
          print('Loaded ${_items.length} items from storage');
        }
      } else {
        _items = [];
        if (kDebugMode) {
          print('No items found in storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading cart items: $e');
      }
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  // Save cart items to SharedPreferences
  Future<void> _saveCartItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = jsonEncode(_items);
      await prefs.setString('cart_items', encodedData);
      if (kDebugMode) {
        print('Saved ${_items.length} items to storage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving cart items: $e');
      }
    }
  }
  
  void addItem(Map<String, dynamic> item) {
    // Ensure item has an id
    if (!item.containsKey('id')) {
      item = {...item, 'id': DateTime.now().millisecondsSinceEpoch.toString()};
    }
    
    // Check if item already exists in cart
    final existingIndex = _items.indexWhere((i) => i['id'].toString() == item['id'].toString());
    
    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex]['quantity'] = (_items[existingIndex]['quantity'] ?? 1) + 1;
      if (kDebugMode) {
        print('Updated quantity for item ${item['name']}');
      }
    } else {
      // Add new item with quantity 1
      final newItem = {...item, 'quantity': 1};
      _items.add(newItem);
      if (kDebugMode) {
        print('Added new item ${item['name']} to cart');
      }
    }
    
    _saveCartItems();
    notifyListeners();
  }
  
  void removeItem(String id) {
    _items.removeWhere((item) => item['id'].toString() == id.toString());
    _saveCartItems();
    notifyListeners();
  }
  
  void updateQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item['id'].toString() == id.toString());
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
    return _items.fold(0.0, (sum, item) {
      final price = (item['price'] is int) 
          ? (item['price'] as int).toDouble() 
          : (item['price'] is double) 
              ? (item['price'] as double) 
              : 0.0;
      final quantity = (item['quantity'] is int) ? (item['quantity'] as int) : 1;
      return sum + (price * quantity);
    });
  }
  
  double get deliveryFee {
    // You can implement dynamic delivery fee calculation here
    return _items.isEmpty ? 0.0 : 500.0;
  }
  
  double get total {
    return totalAmount + deliveryFee;
  }
  
  int get itemCount {
    int count = 0;
    for (var item in _items) {
      count += (item['quantity'] is int) ? (item['quantity'] as int) : 1;
    }
    return count;
  }
}