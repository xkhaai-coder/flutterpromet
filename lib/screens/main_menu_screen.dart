import 'package:flutter/material.dart';

// Import layar
import 'level_select_screen.dart';
import 'shop_screen.dart'; // <--- IMPORT SHOP SCREEN DI SINI

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

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
            // Tombol Back ke Landing Screen
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Judul Halaman
            const Align(
              alignment: Alignment(0.0, -0.7),
              child: Text(
                'MAIN MENU',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),

            // 3 Pilihan Tombol: Misi, Toko, MyPC
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'MISI',
                    icon: Icons.assignment_outlined,
                    color: Colors.amber,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelSelectScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'TOKO',
                    icon: Icons.shopping_cart_outlined,
                    color: Colors.cyan,
                    onTap: () {
                      // Buka Layar Toko
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShopScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'MyPC',
                    icon: Icons.computer_outlined,
                    color: Colors.purpleAccent,
                    onTap: () {
                      // Buka MyPC (Layar belum dibuat)
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF1B243B).withAlpha(220),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(100),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
