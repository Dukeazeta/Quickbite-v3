import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:quickbitev3/screens/order/order_tracking_screen.dart';
import 'screens/restaurant/restaurant_details_screen.dart';
import 'screens/food/food_details_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/home/food_items_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'package:quickbitev3/screens/checkout/checkout_screen.dart';
import 'package:quickbitev3/screens/settings/settings_screen.dart';
import 'package:quickbitev3/screens/support/support_screen.dart';
import 'package:quickbitev3/screens/orders/orders_screen.dart';
import 'package:quickbitev3/screens/profile/favorites_screen.dart';
import 'package:quickbitev3/screens/profile/addresses_screen.dart';
import 'package:quickbitev3/screens/profile/payment_methods_screen.dart';
import 'package:quickbitev3/screens/profile/edit_profile_screen.dart';
import 'package:quickbitev3/screens/search/search_screen.dart'; // Add this import
import 'package:quickbitev3/screens/cart/cart_screen.dart';     // Add this import
import 'package:quickbitev3/services/cart_service.dart';
import 'package:quickbitev3/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickbitev3/widgets/icon_test.dart';

// Ensure initialization happens only once
bool _initialized = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!_initialized) {
    _initialized = true;

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Enable error reporting in debug mode
    if (kDebugMode) {
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
    }
    
    // Remove the problematic SVG precaching code
    // We'll handle SVG loading in a simpler way
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickBite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const FoodItemsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/support': (context) => const SupportScreen(),
        '/orders': (context) => const OrdersScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/addresses': (context) => const AddressesScreen(),
        '/payments': (context) => const PaymentMethodsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/track_order') {
          // Extract the orderId from the arguments
          final args = settings.arguments as Map<String, dynamic>;
          final orderId = args['orderId'] as String;

          return MaterialPageRoute(
            builder: (context) => OrderTrackingScreen(orderId: orderId),
          );
        }
        return null;
      },
    );
  }
}
