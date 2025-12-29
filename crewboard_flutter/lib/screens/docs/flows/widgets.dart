import 'package:flutter/material.dart';
import '../../../config/palette.dart';
// import 'package:frontend/widgets/widgets.dart'; // Old widgets path, may need specific replacements if used
// import '../../../widgets/button.dart'; // Need to check if Button exists or replace
// import '../../../widgets/textbox.dart'; // Need to check if TextBox exists or replace

// Assuming standard Flutter widgets or existing project widgets are sufficient for basic drawings.
// The custom painters are key.

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 0;

    Offset start = Offset(size.width / 2, 0);
    Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, paint);

    start = Offset(size.width, size.height / 2);
    end = Offset(size.width / 2, size.height);

    canvas.drawLine(start, end, paint);

    start = Offset(size.width / 2, size.height);
    end = Offset(0, size.height / 2);

    canvas.drawLine(start, end, paint);

    start = Offset(0, size.height / 2);
    end = Offset(size.width / 2, 0);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DiamondHighlightPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DiamondHighlightPainter({
    this.color = Colors.yellowAccent,
    this.strokeWidth = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Condition extends StatelessWidget {
  const Condition({
    super.key,
    required this.label,
    required this.width,
    required this.height,
    this.highlight = false,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.mouseCursor,
  });
  final String label;
  final double width;
  final double height;
  final bool highlight;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: mouseCursor ?? SystemMouseCursors.basic,
      child: GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: CustomPaint(
          painter: LinePainter(),
          foregroundPainter: highlight ? DiamondHighlightPainter() : null,
          child: Container(
            padding: EdgeInsets.all(width / 4),
            width: width,
            height: width,
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 13, color: Pallet.font1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Terminal extends StatelessWidget {
  const Terminal({
    super.key,
    required this.label,
    required this.width,
    required this.height,
    this.highlight = false,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.mouseCursor,
  });
  final String label;
  final double width;
  final double height;
  final bool highlight;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: mouseCursor ?? SystemMouseCursors.basic,
      child: GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: highlight ? 3 : 1),
            borderRadius: BorderRadius.circular(40),
            color: Pallet.inside2, // Added background for better visibility
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Pallet.font1),
            ),
          ),
        ),
      ),
    );
  }
}

class Process extends StatelessWidget {
  const Process({
    super.key,
    required this.label,
    required this.width,
    required this.height,
    this.highlight = false,
    this.onHover,
    this.onUnhover,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.mouseCursor,
  });
  final String label;
  final double width;
  final double height;
  final bool highlight;
  final VoidCallback? onHover;
  final VoidCallback? onUnhover;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover?.call(),
      onExit: (_) => onUnhover?.call(),
      cursor: mouseCursor ?? SystemMouseCursors.basic,
      child: GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: highlight ? 3 : 1),
            borderRadius: BorderRadius.circular(8),
            color: Pallet.inside2,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Pallet.font1),
            ),
          ),
        ),
      ),
    );
  }
}
