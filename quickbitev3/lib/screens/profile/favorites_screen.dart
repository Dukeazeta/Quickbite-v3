import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Favorites',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                text: 'Food Items',
                icon: Icon(Icons.fastfood),
              ),
              Tab(
                text: 'Restaurants',
                icon: Icon(Icons.restaurant),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFoodItemsList(context),
            _buildRestaurantsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemsList(BuildContext context) {
    // Demo data
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            title: Text(
              'Favorite Food Item ${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Restaurant Name • \$${(9.99 + index).toStringAsFixed(2)}',
              style: GoogleFonts.poppins(),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                // Remove from favorites
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed from favorites'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
            onTap: () {
              // Navigate to food details
            },
          ),
        );
      },
    );
  }

  Widget _buildRestaurantsList(BuildContext context) {
    // Demo data
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Center(
                  child: Icon(
                    Icons.restaurant,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            title: Text(
              'Favorite Restaurant ${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Fast Food • 4.${5 + index} ★',
              style: GoogleFonts.poppins(),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                // Remove from favorites
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed from favorites'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
            onTap: () {
              // Navigate to restaurant details
            },
          ),
        );
      },
    );
  }
}