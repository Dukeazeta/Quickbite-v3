import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/food_items_screen.dart';
import 'screens/restaurant/restaurant_details_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'AzeretMono',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'AzeretMono',
              bodyColor: Colors.grey[800],
            ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const FoodItemsScreen(),
        '/restaurant_details': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          return RestaurantDetailsScreen(
            restaurantName: args?['restaurantName'] ?? 'Nigerian Delights',
            imageUrl: args?['imageUrl'],
          );
        },
      },
    );
  }
}
