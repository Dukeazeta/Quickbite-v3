import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  
  List<Map<String, dynamic>> get items => List.unmodifiable(_items);
  
  int get itemCount => _items.length;
  
  double get subtotal {
    double total = 0;
    for (var item in _items) {
      total += (item['price'] as num) * (item['quantity'] as num);
    }
    return total;
  }
  
  final double deliveryFee = 500;
  
  double get total => subtotal + deliveryFee;
  
  void addItem(Map<String, dynamic> item) {
    // Check if the item already exists in the cart
    final existingIndex = _items.indexWhere((i) => 
      i['id'] == item['id'] && 
      i['size'] == item['size'] && 
      _areAddonsEqual(i['addons'] as List, item['addons'] as List)
    );
    
    if (existingIndex != -1) {
      // If the item exists, update the quantity
      _items[existingIndex]['quantity'] = (_items[existingIndex]['quantity'] as int) + (item['quantity'] as int);
    } else {
      // Otherwise, add the new item
      _items.add(Map<String, dynamic>.from(item));
    }
    
    notifyListeners();
  }
  
  void updateQuantity(int index, int quantity) {
    if (index < 0 || index >= _items.length) return;
    
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index]['quantity'] = quantity;
    }
    
    notifyListeners();
  }
  
  void removeItem(int index) {
    if (index < 0 || index >= _items.length) return;
    
    _items.removeAt(index);
    notifyListeners();
  }
  
  void clear() {
    _items.clear();
    notifyListeners();
  }
  
  bool _areAddonsEqual(List list1, List list2) {
    if (list1.length != list2.length) return false;
    
    for (var item in list1) {
      if (!list2.contains(item)) return false;
    }
    
    return true;
  }
}