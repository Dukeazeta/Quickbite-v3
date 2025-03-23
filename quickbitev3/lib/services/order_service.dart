import 'dart:async';
import 'dart:math';
import '../models/order.dart';

class OrderService {
  // Mock data for demonstration purposes
  // In a production app, this would connect to your backend API
  
  Future<Order> getOrderById(String orderId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return mock order data
    return Order(
      id: orderId,
      restaurantName: "Mama's Kitchen",
      status: _getRandomStatus(),
      items: [
        OrderItem(
          id: '1',
          name: 'Jollof Rice with Chicken',
          price: 2500.0,
          quantity: 2,
          imageUrl: 'https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg',
        ),
        OrderItem(
          id: '2',
          name: 'Moin Moin',
          price: 800.0,
          quantity: 1,
          imageUrl: 'https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg',
        ),
      ],
      subtotal: 5800.0,
      deliveryFee: 500.0,
      discount: 1000.0,
      deliveryAddress: '123 Main Street, Lagos',
      paymentMethod: 'Card',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      statusUpdates: _generateStatusUpdates(),
      restaurantLocation: {'latitude': 6.5244, 'longitude': 3.3792},
      deliveryLocation: {'latitude': 6.5355, 'longitude': 3.3087},
      driverLocation: {'latitude': 6.5300, 'longitude': 3.3400},
      driverName: 'John Doe',
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
    );
  }

  Future<List<Order>> getUserOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return mock orders
    return [
      Order(
        id: '12345',
        restaurantName: "Mama's Kitchen",
        status: 'Delivered',
        items: [
          OrderItem(
            id: '1',
            name: 'Jollof Rice with Chicken',
            price: 2500.0,
            quantity: 2,
            imageUrl: 'https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg',
          ),
        ],
        subtotal: 5000.0,
        deliveryFee: 500.0,
        discount: 0.0,
        deliveryAddress: '123 Main Street, Lagos',
        paymentMethod: 'Card',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        statusUpdates: _generateStatusUpdates(delivered: true),
        restaurantLocation: {'latitude': 6.5244, 'longitude': 3.3792},
        deliveryLocation: {'latitude': 6.5355, 'longitude': 3.3087},
      ),
      Order(
        id: '12346',
        restaurantName: 'Chicken Republic',
        status: 'Out for Delivery',
        items: [
          OrderItem(
            id: '1',
            name: 'Chicken and Chips',
            price: 3000.0,
            quantity: 1,
            imageUrl: 'https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg',
          ),
        ],
        subtotal: 3000.0,
        deliveryFee: 500.0,
        discount: 500.0,
        deliveryAddress: '123 Main Street, Lagos',
        paymentMethod: 'Cash on Delivery',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        statusUpdates: _generateStatusUpdates(outForDelivery: true),
        restaurantLocation: {'latitude': 6.5244, 'longitude': 3.3792},
        deliveryLocation: {'latitude': 6.5355, 'longitude': 3.3087},
        driverLocation: {'latitude': 6.5300, 'longitude': 3.3400},
        driverName: 'Jane Smith',
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 15)),
      ),
    ];
  }

  Future<Order> placeOrder({
    required List<OrderItem> items,
    required String deliveryAddress,
    required String paymentMethod,
    required double subtotal,
    required double deliveryFee,
    required double discount,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // In a real app, this would send the order to your backend
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    
    return Order(
      id: orderId,
      restaurantName: "Mama's Kitchen", // Assuming all items are from the same restaurant
      status: 'Pending',
      items: items,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      discount: discount,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
      statusUpdates: [
        StatusUpdate(
          status: 'Pending',
          timestamp: DateTime.now(),
          message: 'Your order has been received',
        ),
      ],
      restaurantLocation: {'latitude': 6.5244, 'longitude': 3.3792},
      deliveryLocation: {'latitude': 6.5355, 'longitude': 3.3087},
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 45)),
    );
  }

  String _getRandomStatus() {
    final statuses = [
      'Pending',
      'Confirmed',
      'Preparing',
      'Ready for Pickup',
      'Out for Delivery',
      'Delivered',
    ];
    return statuses[Random().nextInt(statuses.length)];
  }

  List<StatusUpdate> _generateStatusUpdates({
    bool delivered = false,
    bool outForDelivery = false,
  }) {
    final now = DateTime.now();
    final updates = <StatusUpdate>[];
    
    // Order placed
    updates.add(StatusUpdate(
      status: 'Pending',
      timestamp: now.subtract(const Duration(minutes: 30)),
      message: 'Your order has been received',
    ));
    
    // Order confirmed
    updates.add(StatusUpdate(
      status: 'Confirmed',
      timestamp: now.subtract(const Duration(minutes: 25)),
      message: 'Restaurant has confirmed your order',
    ));
    
    // Preparing
    updates.add(StatusUpdate(
      status: 'Preparing',
      timestamp: now.subtract(const Duration(minutes: 20)),
      message: 'Your food is being prepared',
    ));
    
    if (outForDelivery || delivered) {
      // Ready for pickup
      updates.add(StatusUpdate(
        status: 'Ready for Pickup',
        timestamp: now.subtract(const Duration(minutes: 10)),
        message: 'Your order is ready for pickup',
      ));
      
      // Out for delivery
      updates.add(StatusUpdate(
        status: 'Out for Delivery',
        timestamp: now.subtract(const Duration(minutes: 5)),
        message: 'Driver is on the way to deliver your order',
      ));
    }
    
    if (delivered) {
      // Delivered
      updates.add(StatusUpdate(
        status: 'Delivered',
        timestamp: now,
        message: 'Your order has been delivered. Enjoy!',
      ));
    }
    
    return updates;
  }
}