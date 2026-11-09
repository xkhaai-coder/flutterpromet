import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kunci layar ke Landscape
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Fullscreen tanpa status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyPcGameApp());
}

class MyPcGameApp extends StatelessWidget {
  const MyPcGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1B243B),
        canvasColor: const Color(0xFF1B243B),
        colorScheme: const ColorScheme.dark(surface: Color(0xFF1B243B)),
      ),
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  _startLoading() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // Transisi Fade yang mulus tanpa flash putih
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LandingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B243B),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(67),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 181,
                  height: 195,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 181,
                    height: 195,
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withValues(alpha: 0.15),
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
              const SizedBox(height: 24),
              const SizedBox(
                width: 180,
                child: LinearProgressIndicator(
                  color: Color(0xFF8C3AFF),
                  backgroundColor: Colors.white12,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
