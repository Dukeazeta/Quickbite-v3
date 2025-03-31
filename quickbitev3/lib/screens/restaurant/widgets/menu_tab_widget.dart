import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTabWidget extends StatefulWidget {
  const MenuTabWidget({super.key});

  @override
  State<MenuTabWidget> createState() => _MenuTabWidgetState();
}

class _MenuTabWidgetState extends State<MenuTabWidget> {
  final List<String> _categories = [
    'All',
    'Popular',
    'Soups',
    'Rice',
    'Swallow',
    'Protein',
    'Drinks'
  ];
  
  String _selectedCategory = 'All';
  
  // Sample food items data
  final List<Map<String, dynamic>> _foodItems = [
    {
      'name': 'Jollof Rice',
      'description': 'Spicy rice cooked with tomatoes, peppers, and spices',
      'price': 2500,
      'imageUrl': 'https://source.unsplash.com/random/800x600/?jollof-rice',
      'rating': 4.8,
      'restaurant': 'Nigerian Delights',
      'category': 'Rice',
      'popular': true,
    },
    {
      'name': 'Egusi Soup',
      'description': 'Traditional Nigerian soup made with ground melon seeds',
      'price': 3000,
      'imageUrl': 'https://source.unsplash.com/random/800x600/?nigerian-soup',
      'rating': 4.6,
      'restaurant': 'Nigerian Delights',
      'category': 'Soups',
      'popular': true,
    },
    {
      'name': 'Pounded Yam',
      'description': 'Smooth, stretchy dough made from yam',
      'price': 1500,
      'imageUrl': 'https://source.unsplash.com/random/800x600/?pounded-yam',
      'rating': 4.5,
      'restaurant': 'Nigerian Delights',
      'category': 'Swallow',
      'popular': false,
    },
    {
      'name': 'Suya',
      'description': 'Spicy skewered meat, typically beef',
      'price': 2000,
      'imageUrl': 'https://source.unsplash.com/random/800x600/?grilled-meat',
      'rating': 4.9,
      'restaurant': 'Nigerian Delights',
      'category': 'Protein',
      'popular': true,
    },
    {
      'name': 'Chapman',
      'description': 'Refreshing non-alcoholic cocktail',
      'price': 1000,
      'imageUrl': 'https://source.unsplash.com/random/800x600/?cocktail',
      'rating': 4.7,
      'restaurant': 'Nigerian Delights',
      'category': 'Drinks',
      'popular': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredFoodItems {
    if (_selectedCategory == 'All') {
      return _foodItems;
    } else if (_selectedCategory == 'Popular') {
      return _foodItems.where((item) => item['popular'] == true).toList();
    } else {
      return _foodItems.where((item) => item['category'] == _selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Categories
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = category == _selectedCategory;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red[700] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        // Food Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredFoodItems.length,
            itemBuilder: (context, index) {
              final foodItem = _filteredFoodItems[index];
              
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/food_details',
                    arguments: foodItem,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Food Image
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: Image.network(
                          foodItem['imageUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(Icons.restaurant, color: Colors.grey),
                          ),
                        ),
                      ),
                      
                      // Food Details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                foodItem['description'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₦${foodItem['price']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[700],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${foodItem['rating']}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}