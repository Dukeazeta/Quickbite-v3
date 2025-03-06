import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import
import '../../blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isValidEmail = true; // Add this line to track email validity

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Add this method to validate email format
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthSuccess) {
            // TODO: Navigate to home screen
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48),
                        // Logo and App Name
                        const SizedBox(height: 60),
                        const Text(
                          'QuickBite',
                          style: TextStyle(
                            color: Color.fromRGBO(244, 67, 54, 1),
                            fontSize: 54,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Boxing',
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Your favourite food in one place',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 64),
                        // Email TextField
                        TextField(
                          controller: _emailController,
                          style: GoogleFonts.montserrat(color: Colors.white),
                          onChanged: (value) {
                            setState(() {
                              _isValidEmail =
                                  value.isEmpty || _validateEmail(value);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle:
                                GoogleFonts.montserrat(color: Colors.grey[600]),
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            errorText: _isValidEmail
                                ? null
                                : 'Please enter a valid email',
                            suffixIcon: _emailController.text.isNotEmpty
                                ? Icon(
                                    _isValidEmail
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: _isValidEmail
                                        ? Colors.green
                                        : Colors.red,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Password TextField
                        TextField(
                          controller: _passwordController,
                          obscureText:
                              _obscurePassword, // Use the variable here
                          style: GoogleFonts.montserrat(
                              color: Colors.white), // Updated to use Montserrat
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: GoogleFonts.montserrat(
                                color: Colors
                                    .grey[600]), // Updated to use Montserrat
                            filled: true,
                            fillColor: Colors.grey[900],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            // Add suffix icon for password toggle
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  LoginWithEmailPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                  ),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black)
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                        ),
                        const SizedBox(height: 8),
                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Your Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Or Continue With
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[800])),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Or Continue With',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[800])),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Social Login Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.facebook, color: Colors.white),
                                label: Text('Facebook',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[900],
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.g_mobiledata,
                                    color: Colors
                                        .white), // Using a Google-like icon from Material Icons
                                label: Text('Google',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[900],
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _socialLoginButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

//Background gridline
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3) // Changed to white
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Create a gradient for the fade effect
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white.withOpacity(0.3), // Changed to white
        Colors.transparent,
      ],
      stops: const [0.0, 0.5],
    );

    // Number of grid lines
    const int horizontalLines = 15;
    const int verticalLines = 15;

    // Draw curved grid lines
    final double horizontalSpacing = size.width / horizontalLines;
    final double verticalSpacing = size.height / verticalLines;

    // Draw horizontal curved lines
    for (int i = 0; i <= horizontalLines; i++) {
      final path = Path();
      final y = i * verticalSpacing;

      path.moveTo(0, y);

      // Create a curved line
      path.quadraticBezierTo(
          size.width / 2, y + (i % 2 == 0 ? 20 : -20), size.width, y);

      // Apply gradient to the path
      final linePaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawPath(path, linePaint);
    }

    // Draw vertical curved lines
    for (int i = 0; i <= verticalLines; i++) {
      final path = Path();
      final x = i * horizontalSpacing;

      path.moveTo(x, 0);

      // Create a curved line
      path.quadraticBezierTo(
          x + (i % 2 == 0 ? 20 : -20), size.height / 2, x, size.height);

      // Apply gradient to the path
      final linePaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
