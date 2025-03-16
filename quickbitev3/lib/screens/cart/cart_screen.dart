import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widgets/cart_item_card.dart';
import 'widgets/cart_summary.dart';
import 'widgets/empty_cart.dart';
import 'package:quickbitev3/services/cart_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartService>(
      builder: (context, cartService, child) {
        final cartItems = cartService.items;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              if (cartItems.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    // Show confirmation dialog before clearing cart
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Clear Cart',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          'Are you sure you want to remove all items from your cart?',
                          style: GoogleFonts.poppins(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              cartService.clearCart();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Clear',
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  label: Text(
                    'Clear',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          body: cartItems.isEmpty
              ? const EmptyCart()
              : Column(
                  children: [
                    // Cart Items List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return CartItemCard(
                            item: item,
                            onUpdateQuantity: (id, quantity) {
                              cartService.updateQuantity(id, quantity);
                            },
                            onRemove: (id) {
                              cartService.removeItem(id);
                            },
                          );
                        },
                      ),
                    ),
                    
                    // Cart Summary
                    CartSummary(
                      subtotal: cartService.totalAmount,
                      deliveryFee: cartService.deliveryFee,
                      total: cartService.total,
                      onCheckout: () {
                        Navigator.pushNamed(context, '/checkout', arguments: {
                          'subtotal': cartService.totalAmount,
                          'deliveryFee': cartService.deliveryFee,
                          'total': cartService.total,
                        });
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
