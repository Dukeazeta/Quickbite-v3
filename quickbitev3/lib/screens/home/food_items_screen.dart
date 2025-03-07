import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/login_screen.dart'; // Add this import

class FoodItemsScreen extends StatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  State<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // User profile image
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://randomuser.me/api/portraits/women/44.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      color: Colors.grey[400],
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // User greeting
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey Bello',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'What would you like to eat?',
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Notification icon - updated to square with rounded corners
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rounded search bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 5,
                  ),
                ),
                onChanged: (value) {
                  // TODO: Implement search functionality
                },
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 20),
            // Categories section
            // Update category section title
            Text(
              'Categories',
              style: GoogleFonts.montserrat(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem('Fast Food', Icons.fastfood),
                  _buildCategoryItem('Pizza', Icons.local_pizza),
                  _buildCategoryItem('Desserts', Icons.icecream),
                  _buildCategoryItem('Healthy', Icons.spa),
                  _buildCategoryItem('African', Icons.restaurant),
                  _buildCategoryItem('Asian', Icons.ramen_dining),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Featured restaurants section
            // Update restaurant section title
            Text(
              'Featured Restaurants',
              style: GoogleFonts.montserrat(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Restaurant grid - takes remaining space
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 6, // Mock data count
                itemBuilder: (context, index) {
                  return _buildRestaurantCard(
                    name: 'Restaurant ${index + 1}',
                    cuisine: index % 2 == 0 ? 'Fast Food' : 'Local Cuisine',
                    rating: 4.5 + (index * 0.1),
                    deliveryTime: '${20 + (index * 5)} mins',
                    imageUrl:
                        'https://source.unsplash.com/random/300x200?restaurant,food,$index',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom menu button widget
class CustomMenuButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomMenuButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 2,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Container(
            width: 15,
            height: 2,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          Container(
            width: 20,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

// Profile avatar widget
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
          size: 20,
        ),
      ),
      color: Colors.grey[900],
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'profile',
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: Text(
              'Profile',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'orders',
          child: ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.white),
            title: Text(
              'My Orders',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: Text(
              'Settings',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: Text(
              'Logout',
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'logout') {
          _showLogoutConfirmation(context);
        }
        // Handle other menu options here
      },
    );
  }

  // Show logout confirmation dialog
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Confirm Logout',
            style: GoogleFonts.montserrat(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.montserrat(color: Colors.grey[700]),
          ),
          // Update dialog buttons text colors to Colors.grey[800]
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Use named route navigation to go back to login screen
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                );
              },
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Helper method to build category items
Widget _buildCategoryItem(String title, IconData icon) {
  return Container(
    width: 80,
    margin: const EdgeInsets.only(right: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color.fromRGBO(244, 67, 54, 1),
          size: 32,
        ),
        const SizedBox(height: 8),
        // In _buildCategoryItem
        Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.grey[800],
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// Helper method to build restaurant cards
Widget _buildRestaurantCard({
  required String name,
  required String cuisine,
  required double rating,
  required String deliveryTime,
  required String imageUrl,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            imageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 120,
                color: Colors.grey[800],
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(244, 67, 54, 1),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                color: Colors.grey[800],
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: 40,
                ),
              );
            },
          ),
        ),
        // Restaurant details
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.montserrat(
                  color: Colors.grey[900],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                cuisine,
                style: GoogleFonts.montserrat(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      // Update rating and delivery time text
                      Text(
                        rating.toString(),
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        deliveryTime,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey[800],
                          fontSize: 12,
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
  );
}
