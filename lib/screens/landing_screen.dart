import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_menu_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Logo / Ilustrasi di Tengah
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(67),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 195,
                    height: 181,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 195,
                      height: 181,
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withAlpha(40),
                        borderRadius: BorderRadius.circular(67),
                      ),
                      child: const Icon(
                        Icons.computer,
                        size: 80,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tombol QUIT (Kiri)
            Positioned(
              left: 127,
              bottom: 40,
              child: AnimatedGameButton(
                label: 'QUIT',
                width: 175,
                height: 48,
                fontSize: 24,
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),

            // Tombol PLAY (Tengah) -> Masuk ke MainMenuScreen
            Positioned(
              left: 332,
              bottom: 30,
              child: AnimatedGameButton(
                label: 'PLAY',
                width: 209,
                height: 66,
                fontSize: 36,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenuScreen(),
                    ),
                  );
                },
              ),
            ),

            // Tombol SETTING (Kanan)
            Positioned(
              left: 571,
              bottom: 40,
              child: AnimatedGameButton(
                label: 'SETTING',
                width: 175,
                height: 48,
                fontSize: 24,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Animasi Tombol saat Diklik
class AnimatedGameButton extends StatefulWidget {
  final String label;
  final double width;
  final double height;
  final double fontSize;
  final VoidCallback onTap;

  const AnimatedGameButton({
    super.key,
    required this.label,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.onTap,
  });

  @override
  State<AnimatedGameButton> createState() => _AnimatedGameButtonState();
}

class _AnimatedGameButtonState extends State<AnimatedGameButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: const Color(0xFF1B243B),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF8C3AFF), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF8C3AFF),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sansation',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
