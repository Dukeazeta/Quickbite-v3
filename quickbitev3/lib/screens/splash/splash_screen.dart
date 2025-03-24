import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickbitev3/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize services and navigate to the appropriate screen
    _initialize();
  }

  Future<void> _initialize() async {
    // Simulate loading time or perform actual initialization
    await Future.delayed(const Duration(seconds: 2));
    
    // Get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.initialize();
    
    if (mounted) {
      // Navigate to the appropriate screen based on authentication status
      if (authService.isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quickbite',
              style: GoogleFonts.pacifico(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Changed from Colors.red[700] to white for visibility
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
