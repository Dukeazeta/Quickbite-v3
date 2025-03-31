import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/cart_service.dart';
import '../../models/cart_item.dart';
import '../../utils/constants.dart';
import 'widgets/food_details_header.dart';
import 'widgets/food_quantity_selector.dart';
import 'widgets/food_size_selector.dart';
import 'widgets/food_addon_selector.dart';
import 'widgets/add_to_cart_button.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  Map<String, dynamic> _foodItem = {};
  int _quantity = 1;
  double _totalPrice = 0;
  final List<String> _selectedAddons = [];
  String? _selectedSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Get arguments from the route
    final Map<String, dynamic>? args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args != null) {
      setState(() {
        _foodItem = args;
        _totalPrice = (_foodItem['price'] as num).toDouble();
      });
    }
  }

  // Update the _updateTotalPrice method to use the actual price
  void _updateTotalPrice() {
    double basePrice = (_foodItem['price'] as num).toDouble();
    double addonPrice = 0;
    
    // Calculate addon prices
    for (String addon in _selectedAddons) {
      addonPrice += 500; // ₦500 per addon
    }
    
    // Add size price
    double sizePrice = 0;
    if (_selectedSize == 'Medium') {
      sizePrice = 500;
    } else if (_selectedSize == 'Large') {
      sizePrice = 1000;
    }
    
    setState(() {
      _totalPrice = (basePrice + addonPrice + sizePrice) * _quantity;
    });
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _updateTotalPrice();
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _updateTotalPrice();
      });
    }
  }

  void _toggleAddon(String addon) {
    setState(() {
      if (_selectedAddons.contains(addon)) {
        _selectedAddons.remove(addon);
      } else {
        _selectedAddons.add(addon);
      }
      _updateTotalPrice();
    });
  }

  void _selectSize(String size) {
    setState(() {
      _selectedSize = size;
      _updateTotalPrice();
    });
  }

  // In your _addToCart method
  void _addToCart() {
    try {
      // Get the CartService from Provider
      final cartService = Provider.of<CartService>(context, listen: false);
      
      // Create a CartItem from the food details
      final cartItem = CartItem(
        id: _foodItem['id'] ?? DateTime.now().toString(),
        name: _foodItem['name'] ?? 'Food Item',
        price: _totalPrice,
        quantity: _quantity,
        imageUrl: _foodItem['imageUrl'] ?? '',
        restaurantName: _foodItem['restaurant'] ?? 'Restaurant',
        restaurantId: _foodItem['restaurantId'] ?? '1',
      );
      
      // Add to cart
      cartService.addToCart(cartItem);
      
      // Show success message
      final snackBar = SnackBar(
        content: Text(
          '${_foodItem['name']} added to cart!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print('Error adding to cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add to cart: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _foodItem.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Content
                CustomScrollView(
                  slivers: [
                    // Food Image and Header
                    FoodDetailsHeader(
                      imageUrl: _foodItem['imageUrl'] ?? '',
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    
                    // Food Details
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Food Name and Restaurant
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _foodItem['name'] ?? 'Food Item',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _foodItem['restaurant'] ?? 'Restaurant',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.green[700], size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${_foodItem['rating'] ?? 4.5}',
                                        style: GoogleFonts.poppins(
                                          color: Colors.green[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Description
                            Text(
                              _foodItem['description'] ?? 'A delicious dish prepared with the finest ingredients.',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Quantity Selector
                            FoodQuantitySelector(
                              quantity: _quantity,
                              onIncrement: _incrementQuantity,
                              onDecrement: _decrementQuantity,
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Size Selection
                            FoodSizeSelector(
                              selectedSize: _selectedSize,
                              onSizeSelected: _selectSize,
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Add-ons
                            FoodAddonSelector(
                              selectedAddons: _selectedAddons,
                              onToggleAddon: _toggleAddon,
                            ),
                            
                            // Add some space at the bottom for the fixed button
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Add to Cart Button
                AddToCartButton(
                  totalPrice: _totalPrice,
                  onAddToCart: _addToCart,
                ),
              ],
            ),
    );
  }
}