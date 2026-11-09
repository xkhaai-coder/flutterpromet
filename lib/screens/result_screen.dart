import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int coinsEarned;
  final int expEarned;
  final VoidCallback onRetry;
  final VoidCallback onHome;
  final VoidCallback onGoToShop;

  const ResultScreen({
    Key? key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.coinsEarned,
    required this.expEarned,
    required this.onRetry,
    required this.onHome,
    required this.onGoToShop,
  }) : super(key: key);

  int calculateStars() {
    double percentage = (correctAnswers / totalQuestions) * 100;
    if (percentage >= 85) return 3;
    if (percentage >= 60) return 2;
    if (percentage >= 40) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int stars = calculateStars();
    double accuracy = (correctAnswers / totalQuestions) * 100;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B243B), Color(0xFF0A0E1A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0E1A).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: stars > 0
                          ? const Color(0xFF00F0FF)
                          : const Color(0xFFFF007A),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (stars > 0
                                    ? const Color(0xFF00F0FF)
                                    : const Color(0xFFFF007A))
                                .withOpacity(0.3),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title Header
                      Text(
                        stars > 0 ? 'LEVEL SELESAI!' : 'MISI GAGAL',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: stars > 0
                              ? const Color(0xFF00FF88)
                              : const Color(0xFFFF007A),
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              color: stars > 0
                                  ? const Color(0xFF00FF88)
                                  : const Color(0xFFFF007A),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Rating Bintang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Icon(
                            index < stars
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            size: 38,
                            color: index < stars
                                ? const Color(0xFFFFD700)
                                : Colors.grey[700],
                          );
                        }),
                      ),
                      const SizedBox(height: 14),

                      // Stats Panel
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B243B).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF8C3AFF).withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildStatRow(
                              'Jawaban Benar',
                              '$correctAnswers / $totalQuestions',
                              const Color(0xFF00F0FF),
                            ),
                            const Divider(color: Colors.white10, height: 12),
                            _buildStatRow(
                              'Akurasi',
                              '${accuracy.toStringAsFixed(1)}%',
                              const Color(0xFF00FF88),
                            ),
                            const Divider(color: Colors.white10, height: 12),
                            _buildStatRow(
                              'Koin Didapat',
                              '+ $coinsEarned',
                              const Color(0xFFFFD700),
                            ),
                            const Divider(color: Colors.white10, height: 12),
                            _buildStatRow(
                              'EXP Didapat',
                              '+ $expEarned',
                              const Color(0xFF8C3AFF),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: onRetry,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF00F0FF),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'COBA LAGI',
                                style: TextStyle(
                                  color: Color(0xFF00F0FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onHome,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8C3AFF),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'MENU UTAMA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: onGoToShop,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00FF88),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'KE TOKO',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
