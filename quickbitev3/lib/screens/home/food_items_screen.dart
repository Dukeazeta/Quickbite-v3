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
        ),
      ],
      // Fix for logout on hot reload
      onSelected: (value) {
        // Handle menu item selection here instead of onTap
      },
    );
  }
}
