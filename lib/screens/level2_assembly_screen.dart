import 'package:flutter/material.dart';

import '../data/assembly_data.dart';
import '../models/assembly_question.dart';
import '../widgets/explanation_dialog.dart';
import 'result_screen.dart';
import 'shop_screen.dart';

class Level2AssemblyScreen extends StatefulWidget {
  const Level2AssemblyScreen({super.key});

  @override
  State<Level2AssemblyScreen> createState() => _Level2AssemblyScreenState();
}

class _Level2AssemblyScreenState extends State<Level2AssemblyScreen> {
  int currentStepIndex = 0;
  int hearts = 3;
  int correctAnswersCount = 0;

  bool showHowToPlayModal = true;
  bool isWrongAnswerOverlayShowing = false;
  bool isSuccessOverlayShowing = false; // Overlay validasi jawaban benar
  bool isSuccessStateShowing = false;
  AssemblyOption? lastSelectedOption;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showHowToPlayDialog();
    });
  }

  void _showHowToPlayDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A0E1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF00F0FF), width: 2),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.touch_app_rounded, color: Color(0xFF00F0FF), size: 28),
            SizedBox(width: 8),
            Text(
              'CARA BERMAIN (LEVEL 2)',
              style: TextStyle(
                color: Color(0xFF00F0FF),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '1. Perhatikan bagian slot Motherboard yang membutuhkan komponen.\n'
              '2. Drag salah satu dari 4 pilihan opsi ke area Motherboard.\n'
              '3. Pasang komponen yang paling tepat dan kompatibel!\n'
              '4. Jika salah, nyawa kamu akan berkurang 1.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8C3AFF),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                showHowToPlayModal = false;
              });
            },
            child: const Text(
              'MULAI PERAKITAN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onOptionDropped(AssemblyOption option) {
    setState(() {
      lastSelectedOption = option;
    });

    if (option.isCorrect) {
      // Tampilkan state terpasang + Overlay Sukses
      setState(() {
        isSuccessStateShowing = true;
        isSuccessOverlayShowing = true;
        correctAnswersCount++;
      });
    } else {
      // Jawaban Salah
      setState(() {
        hearts--;
        isWrongAnswerOverlayShowing = true;
      });
    }
  }

  void _handleContinueFromSuccess() {
    setState(() {
      isSuccessOverlayShowing = false;
    });
    _advanceToNextStep();
  }

  void _handleContinueFromExplanation() {
    setState(() {
      isWrongAnswerOverlayShowing = false;
    });

    if (hearts <= 0) {
      _navigateToResult();
    } else {
      _advanceToNextStep();
    }
  }

  void _advanceToNextStep() {
    if (currentStepIndex < level2AssemblyData.length - 1) {
      setState(() {
        currentStepIndex++;
        isSuccessStateShowing = false;
        lastSelectedOption = null;
      });
    } else {
      _navigateToResult();
    }
  }

  void _navigateToResult() {
    int totalQuestions = level2AssemblyData.length;
    int coinsEarned = correctAnswersCount * 75;
    int expEarned = correctAnswersCount * 30;

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
              MaterialPageRoute(
                builder: (context) => const Level2AssemblyScreen(),
              ),
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

  // Helper untuk mengubah target hint agar tidak terlalu spesifik / spoiler
  String _getGeneralHint(String targetName) {
    String lower = targetName.toLowerCase();
    if (lower.contains('cpu') || lower.contains('processor'))
      return 'SLOT PROCESSOR';
    if (lower.contains('ram') || lower.contains('memory')) return 'SLOT RAM';
    if (lower.contains('nvme') ||
        lower.contains('ssd') ||
        lower.contains('storage'))
      return 'SLOT STORAGE M.2';
    if (lower.contains('vga') ||
        lower.contains('gpu') ||
        lower.contains('graphics'))
      return 'SLOT PCIE GRAFIS';
    if (lower.contains('cmos') || lower.contains('baterai'))
      return 'SOCKET BATERAI CMOS';
    return 'KOMPONEN MOTHERBOARD';
  }

  @override
  Widget build(BuildContext context) {
    if (level2AssemblyData.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Data Level 2 Kosong!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final AssemblyQuestion currentQuestion =
        level2AssemblyData[currentStepIndex];

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
                    // TOP BAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeaderButton(
                          'KEMBALI',
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
                              color: const Color(0xFF00F0FF),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'MISI ${currentStepIndex + 1}/${level2AssemblyData.length}',
                            style: const TextStyle(
                              color: Color(0xFF00F0FF),
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

                    const SizedBox(height: 10),

                    // HEADER INSTRUKSI
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141A2B),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF8C3AFF),
                          width: 1.5,
                        ),
                      ),
                      child: const Text(
                        'PASANG KOMPONEN YANG TEPAT KE DALAM SLOT MOTHERBOARD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00FF88),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // MAIN AREA
                    Expanded(
                      child: Row(
                        children: [
                          // ZONA DROP TARGET MOTHERBOARD
                          Expanded(
                            flex: 6,
                            child: DragTarget<AssemblyOption>(
                              onWillAcceptWithDetails: (details) => true,
                              onAcceptWithDetails: (details) {
                                _onOptionDropped(details.data);
                              },
                              builder: (context, candidateData, rejectedData) {
                                bool isHovered = candidateData.isNotEmpty;
                                final String boardImageToLoad =
                                    isSuccessStateShowing
                                    ? currentQuestion.afterBoardImage
                                    : currentQuestion.beforeBoardImage;

                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0A0E1A),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isHovered
                                          ? const Color(0xFF00FF88)
                                          : const Color(0xFF00F0FF),
                                      width: isHovered ? 3 : 1.5,
                                    ),
                                    boxShadow: isHovered
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF00FF88)
                                                  .withOpacity(0.4),
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.asset(
                                            boardImageToLoad,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stack) =>
                                                    const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.redAccent,
                                                    ),
                                          ),
                                        ),
                                      ),

                                      // HINT TARGET YANG SUDAH DIPERBAIKI (LEBIH UMUM)
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFF00F0FF),
                                            ),
                                          ),
                                          child: Text(
                                            'TARGET: ${_getGeneralHint(currentQuestion.targetComponentName)}',
                                            style: const TextStyle(
                                              color: Color(0xFF00F0FF),
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 16),

                          // OPSI KOMPONEN DRAGGABLE
                          Expanded(
                            flex: 4,
                            child: GridView.builder(
                              itemCount: currentQuestion.options.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.1,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                              itemBuilder: (context, index) {
                                final option = currentQuestion.options[index];

                                return Draggable<AssemblyOption>(
                                  data: option,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF141A2B),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF00FF88),
                                          width: 2,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black54,
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        option.imagePath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  childWhenDragging: Opacity(
                                    opacity: 0.3,
                                    child: _buildOptionCard(option),
                                  ),
                                  child: _buildOptionCard(option),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // OVERLAY VALIDASI JAWABAN BENAR
            if (isSuccessOverlayShowing) _buildSuccessDialog(),

            // OVERLAY PENJELASAN JAWABAN SALAH
            if (isWrongAnswerOverlayShowing)
              ExplanationDialog(
                correctAnswer: currentQuestion.targetComponentName,
                explanation: currentQuestion.wrongExplanation,
                isGameOver: hearts <= 0,
                onContinue: _handleContinueFromExplanation,
              ),
          ],
        ),
      ),
    );
  }

  // WIDGET SCREEN VALIDASI SUKSES
  Widget _buildSuccessDialog() {
    return Container(
      color: Colors.black.withOpacity(0.85),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0E1A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF00FF88), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FF88).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF00FF88),
                size: 64,
              ),
              const SizedBox(height: 12),
              const Text(
                'KOMPONEN COCOK!',
                style: TextStyle(
                  color: Color(0xFF00FF88),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${lastSelectedOption?.name ?? "Komponen"} berhasil terpasang sempurna.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FF88),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _handleContinueFromSuccess,
                child: const Text(
                  'MISI SELANJUTNYA',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(AssemblyOption option) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141A2B),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF8C3AFF), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                option.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.extension,
                  color: Colors.white54,
                  size: 32,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFF1B243B),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Text(
              option.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
