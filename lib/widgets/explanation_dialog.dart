import 'package:flutter/material.dart';

/// Widget modal overlay untuk pembahasan saat jawaban kurang tepat
class ExplanationDialog extends StatelessWidget {
  final String correctAnswer;
  final String explanation;
  final VoidCallback onContinue;
  final bool isGameOver;

  const ExplanationDialog({
    super.key,
    required this.correctAnswer,
    required this.explanation,
    required this.onContinue,
    this.isGameOver = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withValues(alpha: 0.75),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 480,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141A2B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isGameOver ? Colors.redAccent : const Color(0xFFFF007A),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      (isGameOver ? Colors.redAccent : const Color(0xFFFF007A))
                          .withValues(alpha: 0.3),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (isGameOver
                                ? Colors.redAccent
                                : const Color(0xFFFF007A))
                            .withValues(alpha: 0.2),
                    border: Border.all(
                      color: isGameOver
                          ? Colors.redAccent
                          : const Color(0xFFFF007A),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isGameOver ? 'NYAWA HABIS!' : 'JAWABAN KURANG TEPAT',
                    style: TextStyle(
                      color: isGameOver
                          ? Colors.redAccent
                          : const Color(0xFFFF007A),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Info Jawaban Benar
                Text(
                  'JAWABAN BENAR: $correctAnswer',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF00FF88),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),

                // Penjelasan
                Text(
                  explanation,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),

                // Tombol Aksi
                InkWell(
                  onTap: onContinue,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B243B),
                      border: Border.all(
                        color: isGameOver
                            ? Colors.redAccent
                            : const Color(0xFF00FF88),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isGameOver
                                      ? Colors.redAccent
                                      : const Color(0xFF00FF88))
                                  .withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      isGameOver ? 'ULANGI LEVEL' : 'LANJUTKAN',
                      style: TextStyle(
                        color: isGameOver ? Colors.redAccent : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
  }
}
