import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Top section with dark navy background and doctor images
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
              ),
              child: Stack(
                children: [
                  // Subtle dot pattern overlay
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DotPatternPainter(),
                    ),
                  ),
                  // Doctor images
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Female doctor
                        ClipRRect(
                          child: Image.asset(
                            'assets/images/diana73-dentist-1191671_1920.jpg',
                            height: 280,
                            width: 170,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Male doctor
                        ClipRRect(
                          child: Image.asset(
                            'assets/images/bruno-rodrigues-279xIHymPYY-unsplash.jpg',
                            height: 280,
                            width: 170,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with content
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  const Text(
                    'Appointment, Online Diagnostic, Booking,\nManagement Multi-Vendor App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Find doctors, book appointment\nhave digital consultation, get prescription\nand live healthy life.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Google and Mobile login buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Google Sign In coming soon'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Text(
                            'G',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          label: const Text(
                            'Google Log In',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: AppColors.secondary.withValues(alpha: 0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mobile Log In coming soon'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.phone_android,
                            size: 20,
                            color: AppColors.secondary,
                          ),
                          label: const Text(
                            'Mobile Log In',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: AppColors.secondary.withValues(alpha: 0.2),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  // Already have an account? Log In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
