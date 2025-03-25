import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  // Add these properties
  double _deliveryFee = 500.0; // Default delivery fee
  double _discount = 0.0;
  
  List<CartItem> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }
  
  // Add these getters
  double get deliveryFee => _deliveryFee;
  double get discount => _discount;
  double get total => totalAmount + _deliveryFee - _discount;
  
  // You might want to add setters too
  set deliveryFee(double value) {
    _deliveryFee = value;
    notifyListeners();
  }
  
  set discount(double value) {
    _discount = value;
    notifyListeners();
  }
  
  Future<List<CartItem>> getCartItems() async {
    // In a real app, this might fetch from local storage or an API
    return _items;
  }
  
  void addToCart(CartItem item) {
    // Check if the item already exists in the cart
    final existingIndex = _items.indexWhere((i) => i.id == item.id);
    
    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex] = CartItem(
        id: item.id,
        name: item.name,
        price: item.price,
        quantity: _items[existingIndex].quantity + item.quantity,
        imageUrl: item.imageUrl,
        restaurantName: item.restaurantName,
        restaurantId: item.restaurantId,
      );
    } else {
      // Add new item
      _items.add(item);
    }
    
    notifyListeners();
  }
  
  void updateCartItemQuantity(String id, int quantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _items[index] = CartItem(
        id: _items[index].id,
        name: _items[index].name,
        price: _items[index].price,
        quantity: quantity,
        imageUrl: _items[index].imageUrl,
        restaurantName: _items[index].restaurantName,
        restaurantId: _items[index].restaurantId,
      );
      notifyListeners();
    }
  }
  
  void removeFromCart(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}