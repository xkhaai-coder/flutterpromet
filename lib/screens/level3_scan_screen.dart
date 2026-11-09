import 'dart:async';

import 'package:flutter/material.dart';

import '../models/scan_case.dart';
import '../data/scan_data.dart';
import '../widgets/interactive_cleaner.dart';
import '../widgets/explanation_dialog.dart';
import 'result_screen.dart';

class Level3ScanScreen extends StatefulWidget {
  const Level3ScanScreen({super.key});

  @override
  State<Level3ScanScreen> createState() => _Level3ScanScreenState();
}

class _Level3ScanScreenState extends State<Level3ScanScreen> {
  late ScanCase _activeCase;
  final ScanProgressState _state = ScanProgressState();

  Timer? _gameTimer;
  int _secondsRemaining = 180; // 3 Menit

  @override
  void initState() {
    super.initState();
    // Pilih kasus acak (RAM / CPU)
    _activeCase =
        (ScanData.cases
              ..toList()
              ..shuffle())
            .first;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showHowToPlayModal();
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timerExpired();
      }
    });
  }

  void _timerExpired() {
    _gameTimer?.cancel();
    _showFeedbackDialog(
      titleText: "WAKTU HABIS!",
      explanationText: "Waktu 3 menit telah habis sebelum kamu berhasil menyelesaikan perbaikan.",
      correctAnswerText: "Teliti dan percepat proses perbaikan.",
      onClose: () => Navigator.of(context).pop(),
    );
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _showHowToPlayModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B243B),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF00F0FF), width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'PETUNJUK LEVEL 3: SCAN',
          style: TextStyle(
            color: Color(0xFF00F0FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '1. Baca kasus kerusakan dengan cermat.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 6),
            Text(
              '2. Lepaskan 4 baut panel samping casing untuk membuka PC.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 6),
            Text(
              '3. Gunakan alat pembersih untuk menggosok/merawat komponen.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 6),
            Text(
              '4. Pasang kembali komponen dan tekan POWER TEST.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 6),
            Text(
              '5. Selesaikan misi sebelum timer 03:00 habis!',
              style: TextStyle(color: Color(0xFFFFD700)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Kembalikan ke menu select
            },
            child: const Text(
              'KEMBALI',
              style: TextStyle(color: Color(0xFFFF007A)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF88),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _startTimer();
            },
            child: const Text(
              'MULAI MISI',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _validateAndTestPower() {
    if (!_state.isCaseOpened) {
      _showFeedbackDialog(
        titleText: "PERBAIKAN BELUM SELESAI",
        explanationText: "Kamu belum membuka casing PC! Buka baut panel samping terlebih dahulu.",
        correctAnswerText: "Lepas 4 baut lalu buka casing.",
      );
      return;
    }

    if (_activeCase.type == ScanCaseType.ram) {
      if (!_state.ramCleaned) {
        _showFeedbackDialog(
          titleText: "RAM MASIH KOTOR",
          explanationText: "Konektor pin emas RAM masih kotor. Bersihkan seluruhnya dengan kuas!",
          correctAnswerText: "Gosok pin emas RAM hingga bersih.",
        );
        return;
      }
      if (!_state.ramReinstalled ||
          !_state.ramLeftClipLocked ||
          !_state.ramRightClipLocked) {
        _showFeedbackDialog(
          titleText: "RAM BELUM TERPASANG RAPI",
          explanationText: "Pastikan RAM sudah dipasang kembali ke slot dan kedua pengunci telah dikunci!",
          correctAnswerText: "Pasang RAM dan kunci klip slot.",
        );
        return;
      }
    } else if (_activeCase.type == ScanCaseType.cpu) {
      if (!_state.oldThermalPasteCleaned) {
        _showFeedbackDialog(
          titleText: "THERMAL PASTE LAMA MASIH ADA",
          explanationText: "Bersihkan sisa thermal paste kering pada permukaan CPU terlebih dahulu!",
          correctAnswerText: "Bersihkan sisa pasta lama.",
        );
        return;
      }
      if (!_state.newThermalPasteApplied) {
        _showFeedbackDialog(
          titleText: "THERMAL PASTE BARU BELUM DIAPLIKASIKAN",
          explanationText: "Oleskan thermal paste baru pada permukaan CPU sebelum memasang cooler!",
          correctAnswerText: "Oleskan thermal paste baru.",
        );
        return;
      }
      if (!_state.cpuCoolerReinstalled) {
        _showFeedbackDialog(
          titleText: "CPU COOLER BELUM TERPASANG",
          explanationText: "Pasang kembali CPU cooler di atas prosesor!",
          correctAnswerText: "Pasang kembali CPU cooler.",
        );
        return;
      }
    }

    // BERHASIL!
    _gameTimer?.cancel();
    _showFeedbackDialog(
      titleText: "BOOTING BERHASIL!",
      explanationText:
          "Luar biasa! PC berhasil menyala normal dan lulus pengujian.",
      correctAnswerText: "Perbaikan Selesai!",
      onClose: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              totalQuestions: 1,
              correctAnswers: 1,
              coinsEarned: 150,
              expEarned: 200,
              onRetry: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Level3ScanScreen(),
                  ),
                );
              },
              onHome: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              onGoToShop: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void _showFeedbackDialog({
    required String titleText,
    required String explanationText,
    required String correctAnswerText,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) => ExplanationDialog(
        explanation: "$titleText\n$explanationText",
        correctAnswer: correctAnswerText,
        onContinue: () {
          Navigator.of(context).pop();
          if (onClose != null) onClose();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B243B), Color(0xFF0A0E1A)],
          ),
        ),
        child: Row(
          children: [
            // SIDEBAR KIRI (Control Panel)
            Container(
              width: 240,
              padding: const EdgeInsets.all(12),
              color: const Color(0x40000000),
              child: Column(
                children: [
                  // Tombol KEMBALI
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF007A),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Timer Card
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF8C3AFF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'WAKTU TERSISA',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        Text(
                          _formattedTime,
                          style: const TextStyle(
                            color: Color(0xFF00FF88),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Banner Deskripsi Kasus
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B375F), Color(0xFF8C3AFF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _activeCase.title,
                              style: const TextStyle(
                                color: Color(0xFF00F0FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _activeCase.description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tombol POWER TEST
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF88),
                      minimumSize: const Size.fromHeight(45),
                    ),
                    onPressed: _validateAndTestPower,
                    child: const Text(
                      'POWER TEST',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // WORKSPACE UTAMA (Kanan)
            Expanded(
              child: Stack(
                children: [
                  // Tampilan 1: Casing PC Tertutup & 4 Baut
                  if (!_state.isCaseOpened) ...[
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/level3/case_side_closed.png',
                            width: 450,
                            fit: BoxFit.contain,
                          ),
                          // 4 Baut Sudut
                          if (_state.boltsRemovedCount < 4) ...[
                            Positioned(
                              top: 20,
                              left: 20,
                              child: _buildBoltButton(1),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: _buildBoltButton(2),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: _buildBoltButton(3),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: _buildBoltButton(4),
                            ),
                          ],
                          if (_state.boltsRemovedCount == 4)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00F0FF),
                              ),
                              onPressed: () =>
                                  setState(() => _state.isCaseOpened = true),
                              child: const Text(
                                'GESER / BUKA PANEL CASING',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Tampilan 2: Close-up Area Kerja Motherboard & Komponen
                    _buildMotherboardWorkspace(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoltButton(int boltIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _state.boltsRemovedCount++;
        });
      },
      child: Image.asset(
        'assets/images/level3/case_bolt.png',
        width: 36,
        height: 36,
      ),
    );
  }

  Widget _buildMotherboardWorkspace() {
    return Center(
      child: Container(
        width: 550,
        height: 360,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00F0FF), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/level3/motherboard_close_up.png',
              fit: BoxFit.cover,
              width: 550,
              height: 360,
            ),

            // Interaksi Kasus RAM
            if (_activeCase.type == ScanCaseType.ram) _buildRamCaseMechanics(),

            // Interaksi Kasus CPU
            if (_activeCase.type == ScanCaseType.cpu) _buildCpuCaseMechanics(),
          ],
        ),
      ),
    );
  }

  Widget _buildRamCaseMechanics() {
    return Stack(
      children: [
        // Clip Kiri & Kanan Slot RAM
        Positioned(
          left: 180,
          top: 120,
          child: IconButton(
            icon: Icon(
              _state.ramLeftClipUnlocked ? Icons.lock_open : Icons.lock,
              color: const Color(0xFF00FF88),
            ),
            onPressed: () => setState(
              () => _state.ramLeftClipUnlocked = !_state.ramLeftClipUnlocked,
            ),
          ),
        ),
        Positioned(
          right: 180,
          top: 120,
          child: IconButton(
            icon: Icon(
              _state.ramRightClipUnlocked ? Icons.lock_open : Icons.lock,
              color: const Color(0xFF00FF88),
            ),
            onPressed: () => setState(
              () => _state.ramRightClipUnlocked = !_state.ramRightClipUnlocked,
            ),
          ),
        ),

        // Area Gosok/Usap RAM
        if (_state.ramLeftClipUnlocked &&
            _state.ramRightClipUnlocked &&
            !_state.ramCleaned)
          Center(
            child: SizedBox(
              width: 280,
              height: 100,
              child: InteractiveCleaner(
                cleanImagePath: 'assets/images/level3/ram_clean.png',
                dirtyImagePath: 'assets/images/level3/ram_dirty.png',
                onCleaned: () {
                  setState(() => _state.ramCleaned = true);
                },
              ),
            ),
          ),

        if (_state.ramCleaned)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/level3/ram_clean.png', width: 280),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _state.ramReinstalled = true;
                      _state.ramLeftClipLocked = true;
                      _state.ramRightClipLocked = true;
                    });
                  },
                  child: const Text('PASANG & KUNCI RAM'),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCpuCaseMechanics() {
    return Stack(
      children: [
        if (!_state.cpuCoolerRemoved)
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _state.cpuCoolerRemoved = true),
              child: Image.asset(
                'assets/images/level3/cpu_cooler.png',
                width: 180,
              ),
            ),
          ),

        if (_state.cpuCoolerRemoved && !_state.oldThermalPasteCleaned)
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: InteractiveCleaner(
                cleanImagePath: 'assets/images/level3/cpu_socket_clean.png',
                dirtyImagePath: 'assets/images/level3/cpu_dirty_paste.png',
                onCleaned: () {
                  setState(() => _state.oldThermalPasteCleaned = true);
                },
              ),
            ),
          ),

        if (_state.oldThermalPasteCleaned && !_state.newThermalPasteApplied)
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _state.newThermalPasteApplied = true),
              child: Image.asset(
                'assets/images/level3/cpu_socket_clean.png',
                width: 160,
              ),
            ),
          ),

        if (_state.newThermalPasteApplied)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/level3/cpu_fresh_paste.png',
                  width: 160,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => _state.cpuCoolerReinstalled = true),
                  child: const Text('PASANG CPU COOLER'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
