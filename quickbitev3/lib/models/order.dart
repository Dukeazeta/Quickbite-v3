
class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  double get totalPrice => price * quantity;
}

class StatusUpdate {
  final String status;
  final DateTime timestamp;
  final String? message;

  StatusUpdate({
    required this.status,
    required this.timestamp,
    this.message,
  });
}

class Order {
  final String id;
  final List<OrderItem> items;
  final String deliveryAddress;
  final String paymentMethod;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;
  final String status;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String restaurantName;
  
  // Add these new properties
  final Map<String, double> restaurantLocation;
  final Map<String, double> deliveryLocation;
  final Map<String, double>? driverLocation;
  final String? driverName;
  final List<StatusUpdate> statusUpdates;

  Order({
    required this.id,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.status,
    required this.createdAt,
    required this.restaurantName,
    required this.restaurantLocation,
    required this.deliveryLocation,
    required this.statusUpdates,
    this.estimatedDeliveryTime,
    this.driverLocation,
    this.driverName,
  }) : total = subtotal + deliveryFee - discount;
}

class LatLng {
  final double latitude;
  final double longitude;

  LatLng({
    required this.latitude,
    required this.longitude,
  });
}