import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_menu_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  // =========================================================================
  // KALIBRASI POSISI & UKURAN MEJA + PC
  // =========================================================================
  static const double _stageWidth = 460.0;
  static const double _stageHeight = 445.0;
  static const double _deskWidth = 370.0; // Lebar meja
  static const double _pcWidth = 240.0; // Lebar PC
  static const double _pcLeft = 64.0; // Geser kiri-kanan PC di atas meja
  static const double _pcBottom = 155.0; // Tinggi dudukan PC (di atas meja)
  // =========================================================================

  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  bool _isMuted = false;

  @override
  void initState() {
    super.initState();

    // Kunci orientasi ke Landscape & Fullscreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // 1. Animasi melayang halus untuk PC di atas permukaan meja
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // 2. Animasi denyut glow halus untuk tombol utama START GAME
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.35, end: 0.75).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _showQuitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0D2137),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFFEF5350), width: 1.5),
        ),
        title: const Text(
          'EXIT GAME?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Sansation',
            letterSpacing: 1.2,
          ),
        ),
        content: const Text(
          'Yakin mau keluar dari permainan?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('BATAL', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => SystemNavigator.pop(),
            child: const Text(
              'KELUAR',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final safePadding = MediaQuery.paddingOf(context);

    // Zona aman kiri: meja nempel bawah, PC tetap aman dari tepi atas & notch
    final safeLeft = safePadding.left > 0 ? safePadding.left : 12.0;
    final safeTop = safePadding.top + 12.0;
    final availableWidth = screenSize.width - safeLeft - safePadding.right;
    final leftStageWidth = availableWidth * 0.46;

    return Scaffold(
      backgroundColor: const Color(0xFF071324),
      body: Stack(
        children: [
          // Layer 1: Background Image (assets/images/bekron.png)
          Positioned.fill(
            child: Image.asset(
              'assets/images/bekron.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          // Layer 2: Subtle Vignette Overlay agar UI & teks tetap kontras
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.15,
                  colors: [
                    Colors.black.withValues(alpha: 0.12),
                    Colors.black.withValues(alpha: 0.52),
                  ],
                ),
              ),
            ),
          ),

          // Layer 3: ZONA AMAN MEJA & PC
          Positioned(
            left: safeLeft,
            bottom: 0,
            top: safeTop,
            width: leftStageWidth,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: _stageWidth,
                  height: _stageHeight,
                  child: Stack(
                    children: [
                      // 3A. MEJA: Nempel statis di dasar layar paling bawah
                      Positioned(
                        left: 0,
                        bottom: 0,
                        width: _deskWidth,
                        child: Image.asset(
                          'assets/images/meja.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomLeft,
                          filterQuality: FilterQuality.high,
                        ),
                      ),

                      // 3B. CONTACT SHADOW: Bayangan di atas permukaan meja
                      Positioned(
                        left: _pcLeft + 18,
                        bottom: _pcBottom - 6,
                        width: _pcWidth - 36,
                        height: 24,
                        child: AnimatedBuilder(
                          animation: _floatAnimation,
                          builder: (context, child) {
                            final progress = (_floatAnimation.value.abs() / 6.0)
                                .clamp(0.0, 1.0);
                            final scale = 1.0 - (progress * 0.12);
                            final opacity = 0.65 - (progress * 0.2);

                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.black.withValues(alpha: opacity),
                                      Colors.black.withValues(alpha: 0.0),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // 3C. PC: Duduk & melayang tipis di atas permukaan meja
                      Positioned(
                        left: _pcLeft,
                        bottom: _pcBottom,
                        width: _pcWidth,
                        child: AnimatedBuilder(
                          animation: _floatAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _floatAnimation.value),
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/images/pc.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Layer 4: Konten Kanan (Logo & Tombol Menu)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  // Ruang kiri untuk area Meja & PC
                  const Expanded(flex: 5, child: SizedBox()),

                  // Panel Menu Sebelah Kanan
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 420,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo Utama (assets/images/logo.png)
                              SizedBox(
                                height: 175,
                                width: 420,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // 1. START GAME -> MainMenuScreen
                              AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return GameMenuButton(
                                    label: 'START GAME',
                                    icon: Icons.play_arrow_rounded,
                                    iconSize: 30,
                                    height: 54,
                                    fontSize: 21,
                                    topColor: const Color(0xFFFF7043),
                                    bottomColor: const Color(0xFFD84315),
                                    shadowColor: const Color(0xFF871E00),
                                    borderColor: const Color(0xFFFFAB91),
                                    glowIntensity: _pulseAnimation.value,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const MainMenuScreen(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 12),

                              // 2. ABOUT US & HARDWARE GUIDE
                              Row(
                                children: [
                                  Expanded(
                                    child: GameMenuButton(
                                      label: 'ABOUT US',
                                      icon: Icons.info_outline_rounded,
                                      height: 46,
                                      fontSize: 13.5,
                                      topColor: const Color(0xFF1E88E5),
                                      bottomColor: const Color(0xFF1565C0),
                                      shadowColor: const Color(0xFF0A3266),
                                      borderColor: const Color(0xFF64B5F6),
                                      onTap: () {
                                        // TODO: Hubungkan ke halaman AboutUsScreen
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: GameMenuButton(
                                      label: 'HARDWARE GUIDE',
                                      icon: Icons.memory_rounded,
                                      height: 46,
                                      fontSize: 13.5,
                                      topColor: const Color(0xFF1E88E5),
                                      bottomColor: const Color(0xFF1565C0),
                                      shadowColor: const Color(0xFF0A3266),
                                      borderColor: const Color(0xFF64B5F6),
                                      onTap: () {
                                        // TODO: Hubungkan ke halaman HardwareGuideScreen
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // 3. QUIT (Merah)
                              GameMenuButton(
                                label: 'QUIT',
                                icon: Icons.power_settings_new_rounded,
                                height: 44,
                                fontSize: 15,
                                topColor: const Color(0xFFEF5350),
                                bottomColor: const Color(0xFFC62828),
                                shadowColor: const Color(0xFF7F0000),
                                borderColor: const Color(0xFFFFCDD2),
                                onTap: _showQuitDialog,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Layer 5: Pojok Kanan Atas (Settings & Audio)
          Positioned(
            top: 14,
            right: 20,
            child: SafeArea(
              child: Row(
                children: [
                  _TopIconButton(
                    icon: Icons.settings_rounded,
                    onTap: () {
                      // TODO: Buka modal/halaman setting
                    },
                  ),
                  const SizedBox(width: 10),
                  _TopIconButton(
                    icon: _isMuted
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                    onTap: () {
                      setState(() => _isMuted = !_isMuted);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Layer 6: Versi Aplikasi di Pojok Kanan Bawah
          Positioned(
            bottom: 10,
            right: 20,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 11.5,
                    fontFamily: 'Sansation',
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Button 3D Bevel + Tactile Press
class GameMenuButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final double height;
  final double fontSize;
  final double iconSize;
  final Color topColor;
  final Color bottomColor;
  final Color shadowColor;
  final Color borderColor;
  final double glowIntensity;
  final VoidCallback onTap;

  const GameMenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.topColor,
    required this.bottomColor,
    required this.shadowColor,
    required this.borderColor,
    required this.onTap,
    this.height = 48,
    this.fontSize = 15,
    this.iconSize = 20,
    this.glowIntensity = 0.3,
  });

  @override
  State<GameMenuButton> createState() => _GameMenuButtonState();
}

class _GameMenuButtonState extends State<GameMenuButton> {
  bool _isPressed = false;

  void _handleTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(const Duration(milliseconds: 85));
    if (mounted) {
      setState(() => _isPressed = false);
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => _handleTap(),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 85),
        height: widget.height,
        transform: Matrix4.translationValues(0, _isPressed ? 3.5 : 0.0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.topColor, widget.bottomColor],
          ),
          border: Border.all(color: widget.borderColor, width: 1.6),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color: widget.topColor.withValues(
                      alpha: widget.glowIntensity,
                    ),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white, size: widget.iconSize),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sansation',
                  letterSpacing: 1.2,
                  shadows: const [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 1.5),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tombol Ikon Pojok Kanan Atas
class _TopIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.onTap});

  @override
  State<_TopIconButton> createState() => _TopIconButtonState();
}

class _TopIconButtonState extends State<_TopIconButton> {
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
        scale: _isPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 90),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF0E2942).withValues(alpha: 0.90),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: const Color(0xFF4FC3F7).withValues(alpha: 0.65),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.18),
                blurRadius: 8,
              ),
            ],
          ),
          child: Icon(widget.icon, color: const Color(0xFF81D4FA), size: 22),
        ),
      ),
    );
  }
}
