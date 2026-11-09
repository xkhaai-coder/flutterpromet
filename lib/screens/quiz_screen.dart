import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../models/quiz_question.dart';
import '../widgets/explanation_dialog.dart';
import '../widgets/option_button.dart';
import 'result_screen.dart';
import 'shop_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> activeQuestions;
  int currentQuestionIndex = 0;
  int hearts = 3;
  int correctAnswersCount = 0;
  bool isWrongAnswerOverlayShowing = false;

  @override
  void initState() {
    super.initState();
    _loadRandomQuestions();
  }

  /// Mengacak 20 soal dan mengambil 5 soal saja
  void _loadRandomQuestions() {
    final List<QuizQuestion> shuffled = List.from(level1QuizData)..shuffle();
    activeQuestions = shuffled.take(5).toList();
  }

  /// Memeriksa jawaban user
  void _checkAnswer(String option) {
    QuizQuestion currentQuiz = activeQuestions[currentQuestionIndex];

    if (option == currentQuiz.correctAnswer) {
      correctAnswersCount++;
      _advanceToNextStep();
    } else {
      // Jika salah: Kurangi nyawa & tampilkan ExplanationDialog terlebih dahulu
      setState(() {
        hearts--;
        isWrongAnswerOverlayShowing = true;
      });
    }
  }

  /// Dipanggil saat tombol di ExplanationDialog ditekan
  void _handleContinueFromExplanation() {
    setState(() {
      isWrongAnswerOverlayShowing = false;
    });

    // Cek apakah game over atau lanjut ke langkah berikutnya
    if (hearts <= 0) {
      _navigateToResult();
    } else {
      _advanceToNextStep();
    }
  }

  /// Navigasi ke soal berikutnya ATAU ke ResultScreen jika soal habis
  void _advanceToNextStep() {
    if (currentQuestionIndex < activeQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _navigateToResult();
    }
  }

  /// Mengarahkan player ke ResultScreen membawa hasil dan perhitungan reward
  void _navigateToResult() {
    int totalQuestions = activeQuestions.length;
    int coinsEarned = correctAnswersCount * 50;
    int expEarned = correctAnswersCount * 20;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswersCount,
          coinsEarned: coinsEarned,
          expEarned: expEarned,
          onRetry: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const QuizScreen()),
            );
          },
          onHome: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          onGoToShop: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopScreen()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizQuestion currentQuiz = activeQuestions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1B243B),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B243B), Color(0xFF0A0E1A)],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // TOP BAR HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderButton(
                          'BACK',
                          () => Navigator.pop(context),
                          Colors.redAccent,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B243B),
                            border: Border.all(
                              color: const Color(0xFF00FF88),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'QUESTION ${currentQuestionIndex + 1}/${activeQuestions.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(
                                index < hearts
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.redAccent,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // MAIN QUIZ CONTENT
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // KIRI: GAMBAR & PERTANYAAN
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentQuiz.question,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 200,
                                  height: 130,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF141A2B),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF00F0FF),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      currentQuiz.image,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.image_not_supported,
                                                color: Colors.white54,
                                                size: 40,
                                              ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // KANAN: PILIHAN JAWABAN (2x2 GRID)
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OptionButton(
                                        text: currentQuiz.options[0],
                                        onTap: () => _checkAnswer(
                                          currentQuiz.options[0],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: OptionButton(
                                        text: currentQuiz.options[1],
                                        onTap: () => _checkAnswer(
                                          currentQuiz.options[1],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OptionButton(
                                        text: currentQuiz.options[2],
                                        onTap: () => _checkAnswer(
                                          currentQuiz.options[2],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: OptionButton(
                                        text: currentQuiz.options[3],
                                        onTap: () => _checkAnswer(
                                          currentQuiz.options[3],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Modal Pembahasan (Overlay)
            if (isWrongAnswerOverlayShowing)
              ExplanationDialog(
                correctAnswer: currentQuiz.correctAnswer,
                explanation: currentQuiz.explanation,
                isGameOver: hearts <= 0,
                onContinue: _handleContinueFromExplanation,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(String label, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1B243B),
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
