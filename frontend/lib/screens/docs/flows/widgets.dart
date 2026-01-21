import 'package:flutter/material.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/widgets/widgets.dart';

import '../../../widgets/button.dart';
import '../../../widgets/textbox.dart';

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
            child: Center(child: Text(label, style: TextStyle(fontSize: 13))),
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: highlight ? 3 : 1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(child: Text(label, style: TextStyle(fontSize: 13))),
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: highlight ? 3 : 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Text(label, style: TextStyle(fontSize: 13))),
        ),
      ),
    );
  }
}

class Expandable extends StatefulWidget {
  const Expandable({
    super.key,
    required this.name,
    required this.children,
    required this.onTap,
    required this.selected,
    required this.indent,
    required this.data,
  });
  final String name;
  final Function? onTap;
  final List<Widget> children;
  final bool selected;
  final Map data;

  final double indent;
  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (isOpen) {
              isOpen = false;
            } else if (widget.children.isNotEmpty) {
              isOpen = true;
            }
            if (widget.onTap != null) {
              widget.onTap!();
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: widget.selected
                  ? Pallet.inside2.withOpacity(0.5)
                  : Colors.transparent,
              border: Border(
                top: BorderSide(
                  color: (widget.indent == 0)
                      ? Colors.transparent
                      : Pallet.font3.withOpacity(0.2),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10 * widget.indent),
              child: Row(
                children: [
                  if (widget.children.isNotEmpty)
                    Icon(
                      isOpen
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: Pallet.font3,
                      size: 18,
                    )
                  else
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.transparent,
                      size: 18,
                    ),
                  Expanded(
                    child: Text(widget.name, style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isOpen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          ),
      ],
    );
  }
}
