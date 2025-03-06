import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItemsScreen extends StatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  State<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'QuickBite',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Profile menu with avatar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton(
              icon: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              color: Colors.grey[900],
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: Text(
                      'Profile',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // TODO: Navigate to profile screen
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart, color: Colors.white),
                    title: Text(
                      'My Orders',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // TODO: Navigate to orders screen
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.settings, color: Colors.white),
                    title: Text(
                      'Settings',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // TODO: Navigate to settings screen
                  },
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // TODO: Implement logout functionality
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Text(
          'Food items will be displayed here',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}