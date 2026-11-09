import 'package:flutter/material.dart';

class InteractiveCleaner extends StatefulWidget {
  final String cleanImagePath;
  final String dirtyImagePath;
  final VoidCallback onCleaned;
  final double threshold;

  const InteractiveCleaner({
    super.key,
    required this.cleanImagePath,
    required this.dirtyImagePath,
    required this.onCleaned,
    this.threshold = 0.75, // 75% kebersihan
  });

  @override
  State<InteractiveCleaner> createState() => _InteractiveCleanerState();
}

class _InteractiveCleanerState extends State<InteractiveCleaner> {
  List<Offset> _points = [];
  bool _isCompleted = false;

  void _checkProgress(Size size) {
    if (_isCompleted) return;

    final totalArea = size.width * size.height;
    final clearedArea = _points.length * 300.0; // Estimasi radius usapan

    if ((clearedArea / totalArea) >= widget.threshold) {
      setState(() {
        _isCompleted = true;
      });
      widget.onCleaned();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onPanUpdate: (details) {
            if (_isCompleted) return;
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition = renderBox.globalToLocal(
              details.globalPosition,
            );
            setState(() {
              _points = List.from(_points)..add(localPosition);
            });
            _checkProgress(size);
          },
          child: Stack(
            children: [
              // Lapisan Bersih (Underlay)
              Image.asset(
                widget.cleanImagePath,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                fit: BoxFit.contain,
              ),
              // Lapisan Kotoran yang Terhapus saat Digosok
              if (!_isCompleted)
                ClipPath(
                  clipper: _ScratchClipper(_points),
                  child: Image.asset(
                    widget.dirtyImagePath,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ScratchClipper extends CustomClipper<Path> {
  final List<Offset> points;

  _ScratchClipper(this.points);

  @override
  Path getClip(Size size) {
    Path fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    Path erasePath = Path();

    for (Offset point in points) {
      erasePath.addOval(Rect.fromCircle(center: point, radius: 22.0));
    }

    return Path.combine(PathOperation.difference, fullPath, erasePath);
  }

  @override
  bool shouldReclip(_ScratchClipper oldClipper) => true;
}
