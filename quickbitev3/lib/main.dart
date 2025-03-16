import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/restaurant/restaurant_details_screen.dart';
import 'screens/food/food_details_screen.dart';
import 'package:quickbitev3/screens/auth/login_screen.dart';
import 'package:quickbitev3/screens/splash/splash_screen.dart';
import 'package:quickbitev3/screens/home/food_items_screen.dart';
import 'package:quickbitev3/screens/search/search_screen.dart';
import 'package:quickbitev3/screens/cart/cart_screen.dart';
import 'package:quickbitev3/screens/profile/profile_screen.dart';
import 'package:quickbitev3/screens/checkout/checkout_screen.dart';
import 'package:quickbitev3/services/cart_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickbite',
      debugShowCheckedModeBanner:
          false, // Add this line to remove the debug banner
      theme: ThemeData(
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
        '/': (context) => const FoodItemsScreen(),
        '/restaurant_details': (context) => const RestaurantDetailsScreen(),
        '/food-details': (context) => const FoodDetailsScreen(),
      },
    );
  }
}
