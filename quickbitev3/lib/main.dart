// In your main.dart file, make sure to import the RestaurantDetailsScreen
import 'package:flutter/material.dart';
import 'screens/restaurant/restaurant_details_screen.dart';
import 'screens/food/food_details_screen.dart';
import 'package:quickbitev3/screens/auth/login_screen.dart';
import 'package:quickbitev3/screens/splash/splash_screen.dart';
import 'package:quickbitev3/screens/home/food_items_screen.dart';
import 'package:quickbitev3/screens/search/search_screen.dart';
import 'package:quickbitev3/screens/cart/cart_screen.dart';
import 'package:quickbitev3/screens/profile/profile_screen.dart';
import 'package:quickbitev3/screens/checkout/checkout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickbite',
      theme: ThemeData(
        // Your theme configuration
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const FoodItemsScreen(),
        '/search': (context) => const SearchScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        // Make sure to include the route for restaurant_details
        '/': (context) => const FoodItemsScreen(), // Your home screen
        '/restaurant_details': (context) => const RestaurantDetailsScreen(),
        '/food-details': (context) =>
            const FoodDetailsScreen(), // Use hyphen to match your navigation
      },
    );
  }
}
