import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(String, int) onUpdateQuantity;
  final Function(String) onRemove;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onUpdateQuantity,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = item['id'] ?? '';
    final String name = item['name'] ?? '';
    final String restaurant = item['restaurant'] ?? '';
    final double price = (item['price'] ?? 0).toDouble();
    final String imageUrl = item['imageUrl'] ?? '';
    final int quantity = item['quantity'] ?? 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: Icon(Icons.restaurant, color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    restaurant,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₦${price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.red[700],
                        ),
                      ),
                      const Spacer(),
                      // Inside your CartItemCard build method, update the quantity controls:
                      
                      // Quantity controls
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            // Decrease quantity button
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) {
                                  onUpdateQuantity(id, quantity - 1);
                                } else {
                                  onRemove(id);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            
                            // Quantity display
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                quantity.toString(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            // Increase quantity button
                            GestureDetector(
                              onTap: () {
                                onUpdateQuantity(id, quantity + 1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}