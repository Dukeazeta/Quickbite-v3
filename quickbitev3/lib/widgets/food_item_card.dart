import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickbitev3/services/cart_service.dart';
import 'package:quickbitev3/utils/toast_helper.dart';
import 'package:quickbitev3/utils/svg_icons.dart';

class FoodItemCard extends StatelessWidget {
  final String name;
  final String restaurant;
  final dynamic price;
  final String imageUrl;
  final double rating;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onPressed;

  const FoodItemCard({
    Key? key,
    required this.name,
    required this.restaurant,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.onTap,
    this.onAddToCart,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          onPressed ??
          () {
            Navigator.pushNamed(context, '/food-details');
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: SvgIcons.fastFood(size: 40),
                    ),
                  ),
                ),
                // Add to cart button
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: () {
                      final cartService = Provider.of<CartService>(context, listen: false);
                      cartService.addItem({
                        'id': DateTime.now().millisecondsSinceEpoch.toString(),
                        'name': name,
                        'price': price,
                        'imageUrl': imageUrl,
                        'restaurant': restaurant,
                      });
                      ToastHelper.showCartToast(context, '$name added to cart');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        shape: BoxShape.circle,
                      ),
                      child: SvgIcons.add(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Restaurant Name
                  Text(
                    restaurant,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price is int ? '₦$price' : price.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                      Row(
                        children: [
                          SvgIcons.star(),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
