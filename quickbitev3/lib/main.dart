import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/food_items_screen.dart';

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
        fontFamily: 'AzeretMono',
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'AzeretMono',
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const FoodItemsScreen(),
      },
    );
  }
}
