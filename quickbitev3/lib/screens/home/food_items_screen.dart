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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Custom menu button on the left
              CustomMenuButton(
                onPressed: () {
                  // TODO: Open drawer or menu
                },
              ),

              // QuickBite logo in the center
              const Text(
                'QuickBite',
                style: TextStyle(
                  color: Color.fromRGBO(244, 67, 54, 1),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Boxing',
                  letterSpacing: 1,
                ),
              ),

              // Profile avatar on the right
              ProfileAvatar(),
            ],
          ),
        ),
        elevation: 0,
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
          backgroundColor: Colors.grey[900],
          title: Text(
            'Confirm Logout',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
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
                // Navigate to login screen using direct navigation
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
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
