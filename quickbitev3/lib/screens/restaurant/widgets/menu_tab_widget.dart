import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';

class MenuTabWidget extends StatelessWidget {
  const MenuTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMenuCategory('Most Popular'),
        _buildMenuItemCard(
          'Jollof Rice with Chicken',
          'Spicy rice cooked in tomato sauce with grilled chicken',
          2500,
          'https://source.unsplash.com/random/300x200/?jollof-rice',
          4.8,
          true,
        ),
        _buildMenuItemCard(
          'Suya Platter',
          'Spicy grilled beef skewers with onions and spices',
          3000,
          'https://source.unsplash.com/random/300x200/?grilled-meat',
          4.6,
          false,
        ),
        
        _buildMenuCategory('Starters'),
        _buildMenuItemCard(
          'Moi Moi',
          'Steamed bean pudding with peppers and fish',
          1200,
          'https://source.unsplash.com/random/300x200/?pudding',
          4.5,
          false,
        ),
        _buildMenuItemCard(
          'Puff Puff',
          'Sweet fried dough balls with a hint of nutmeg',
          800,
          'https://source.unsplash.com/random/300x200/?doughnut',
          4.3,
          false,
        ),
        
        _buildMenuCategory('Main Courses'),
        _buildMenuItemCard(
          'Egusi Soup with Pounded Yam',
          'Melon seed soup with beef, fish, and vegetables served with pounded yam',
          3500,
          'https://source.unsplash.com/random/300x200/?soup',
          4.7,
          false,
        ),
        _buildMenuItemCard(
          'Pepper Soup',
          'Spicy broth with goat meat, fish, and aromatic spices',
          3200,
          'https://source.unsplash.com/random/300x200/?spicy-soup',
          4.4,
          false,
        ),
        
        _buildMenuCategory('Desserts'),
        _buildMenuItemCard(
          'Chin Chin',
          'Crunchy fried pastry snack with a sweet taste',
          1000,
          'https://source.unsplash.com/random/300x200/?pastry',
          4.9,
          false,
        ),
        _buildMenuItemCard(
          'Zobo Drink',
          'Refreshing hibiscus drink with pineapple and ginger',
          800,
          'https://source.unsplash.com/random/300x200/?hibiscus-drink',
          4.5,
          false,
        ),
      ],
    );
  }

  Widget _buildMenuCategory(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(
    String name,
    String description,
    double price,
    String imageUrl,
    double rating,
    bool isPopular,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Icon(Icons.restaurant, color: Colors.grey[400]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.red[700], size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'Popular',
                                style: GoogleFonts.poppins(
                                  color: Colors.red[700],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
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
                        '${AppConstants.currencySymbol}${price.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}