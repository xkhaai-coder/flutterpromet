import 'package:flutter/material.dart';

import 'level2_assembly_screen.dart';
import 'level3_scan_screen.dart';
import 'quiz_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  static const Color bgDark = Color(0xFF0A0E1A);
  static const Color panelColor = Color(0xFF192035);
  static const Color cyan = Color(0xFF00F0FF);
  static const Color purple = Color(0xFF8C3AFF);
  static const Color pink = Color(0xFFFF007A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B243B), bgDark],
          ),
        ),
        child: Stack(
          children: [
            // Background Image dengan Opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/Background.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 700;
                  final cardWidth = isWide
                      ? 320.0
                      : (constraints.maxWidth - 48).clamp(0.0, 400.0);

                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            // Header buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildHeaderButton(
                                  label: 'BACK',
                                  borderColor: pink,
                                  onTap: () => Navigator.pop(context),
                                ),
                                _buildHeaderButton(
                                  label: 'MAIN QUEST',
                                  borderColor: purple,
                                  onTap: () {},
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // Screen title
                            const Text(
                              'CHOOSE LEVEL',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sansation',
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Level cards grid (Level 1, Level 2, & Level 3)
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
                              children: [
                                // LEVEL 1 CARD
                                _buildLevelCard(
                                  context,
                                  width: cardWidth,
                                  levelText: 'LEVEL 1\nPENGENALAN KOMPONEN',
                                  isUnlocked: true,
                                  onStart: () => _showHowToPlayDialog(context),
                                ),

                                // LEVEL 2 CARD
                                _buildLevelCard(
                                  context,
                                  width: cardWidth,
                                  levelText: 'LEVEL 2\nPERAKITAN HARDWARE',
                                  isUnlocked: true,
                                  onStart: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Level2AssemblyScreen(),
                                      ),
                                    );
                                  },
                                ),

                                // LEVEL 3 CARD (SCAN)
                                _buildLevelCard(
                                  context,
                                  width: cardWidth,
                                  levelText: 'LEVEL 3\nSCAN & TROUBLESHOOTING',
                                  isUnlocked: true,
                                  onStart: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Level3ScanScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header button
  Widget _buildHeaderButton({
    required String label,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(color: borderColor.withAlpha(150), blurRadius: 10),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sansation',
          ),
        ),
      ),
    );
  }

  // Level card
  Widget _buildLevelCard(
    BuildContext context, {
    required double width,
    required String levelText,
    required bool isUnlocked,
    required VoidCallback onStart,
  }) {
    final borderColor = isUnlocked ? cyan : const Color(0xFF3A4B5C);

    return Container(
      width: width,
      height: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: isUnlocked
            ? [BoxShadow(color: cyan.withAlpha(130), blurRadius: 10)]
            : [],
      ),
      child: Row(
        children: [
          // Component image / Icon placeholder
          Container(
            width: 80,
            height: 110,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 16, 233, 77),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isUnlocked ? Icons.memory : Icons.lock,
              size: 44,
              color: Colors.white70,
            ),
          ),

          const SizedBox(width: 12),

          // Level information and button
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  levelText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sansation',
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: GestureDetector(
                    onTap: isUnlocked ? onStart : null,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isUnlocked
                              ? const [
                                  Color.fromARGB(255, 13, 255, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ]
                              : const [Color(0xFF3A4B5C), Color(0xFF3B375F)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: borderColor, width: 2),
                        boxShadow: isUnlocked
                            ? [
                                BoxShadow(
                                  color: cyan.withAlpha(130),
                                  blurRadius: 7,
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          isUnlocked ? 'MULAI' : 'TERKUNCI',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // How To Play dialog (Level 1)
  void _showHowToPlayDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha(180),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF141A2B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: cyan, width: 2),
                boxShadow: [
                  BoxShadow(color: cyan.withAlpha(130), blurRadius: 10),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'CARA BERMAIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sansation',
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      '1. Baca pertanyaan dengan cermat.\n'
                      '2. Pilih jawaban yang benar.\n'
                      '3. Dapatkan poin untuk setiap jawaban benar!\n\n'
                      'Perhatian: Setiap kesalahan akan '
                      'mengurangi nyawa ❤️!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);

                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => const QuizScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF192035),
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: const Color(0xFF00FF88),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00FF88).withAlpha(130),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Text(
                          'LANJUTKAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sansation',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
