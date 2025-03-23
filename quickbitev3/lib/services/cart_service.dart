import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  
  List<Map<String, dynamic>> get items => _items;
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0, (sum, item) {
      return sum + (item['price'] * (item['quantity'] ?? 1));
    });
  }
  
  double get deliveryFee {
    return _items.isEmpty ? 0 : 500.0;
  }
  
  double get total {
    return totalAmount + deliveryFee;
  }
  
  void addItem(Map<String, dynamic> item) {
    // Check if the item already exists in the cart
    final existingItemIndex = _items.indexWhere((i) => i['id'] == item['id']);
    
    if (existingItemIndex >= 0) {
      // If item exists, increment quantity
      _items[existingItemIndex]['quantity'] = (_items[existingItemIndex]['quantity'] ?? 1) + 1;
    } else {
      // Otherwise add new item with quantity 1
      _items.add({
        ...item,
        'quantity': 1,
        'restaurantId': item['restaurantId'] ?? 'default_restaurant_id',
      });
    }
    
    notifyListeners();
  }
  
  // Replace the existing clear() method with clearCart()
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  
  // Add this method to get cart items
  Future<List<CartItem>> getCartItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Convert the internal items to CartItem objects
    return _items.map((item) => CartItem(
      id: item['id'],
      name: item['name'],
      price: item['price'] is int ? item['price'].toDouble() : item['price'],
      quantity: item['quantity'] ?? 1,
      imageUrl: item['imageUrl'],
      restaurantName: item['restaurant'],
      restaurantId: item['restaurantId'] ?? 'default_restaurant_id',
    )).toList();
  }
  
  void updateCartItemQuantity(String id, int quantity) {
      final index = _items.indexWhere((item) => item['id'] == id);
      if (index >= 0) {
        _items[index]['quantity'] = quantity;
        notifyListeners();
      }
    }
  
  void removeFromCart(String id) {
      _items.removeWhere((item) => item['id'] == id);
      notifyListeners();
    }
}