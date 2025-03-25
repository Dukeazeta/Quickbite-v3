class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  final String restaurantName;
  final String restaurantId;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.restaurantName,
    required this.restaurantId,
  });
}