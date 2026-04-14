import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_flutter/widgets/touchable/touchable.dart';
import 'package:flutter/services.dart';

import 'add_flow.dart';
import 'edit_flow.dart';
import 'types.dart';
import 'flows_controller.dart';
import 'widgets.dart' as flow_widgets;
import 'dart:math' as math;
import 'package:crewboard_flutter/config/palette.dart';

class Flows extends ConsumerWidget {
  const Flows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flowsProvider);
    final notifier = ref.read(flowsProvider.notifier);

    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          if (state.isSelectingLoop ||
              state.isPickingLoopFrom ||
              state.isPickingLoopTo) {
            notifier.cancelLoopSelection();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Stack(
        children: [
          if (state.selectedType == FlowType.condition)
            Container(
              key: Key(state.widgetKey),
              constraints: BoxConstraints(
                maxWidth: state.stageWidth - 100,
              ),
              child: Text(
                state.valueText,
                style: const TextStyle(color: Colors.transparent),
              ),
            )
          else
            Column(
              children: [
                Container(
                  key: Key(state.widgetKey),
                  width: state.widthText.isEmpty
                      ? 0
                      : double.tryParse(state.widthText) ?? 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Center(
                    child: Text(
                      state.valueText,
                      style: const TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          const FlowCanvas(),
          if (state.window == "add" &&
              ((state.currentFlowId != null && state.flows.isEmpty) ||
                  (state.selectedId >= 0)))
            const Align(alignment: Alignment.topRight, child: AddFlow())
          else if (state.window == "edit")
            const Align(alignment: Alignment.topRight, child: EditFlow()),
        ],
      ),
    );
  }
}

class FlowCanvas extends ConsumerWidget {
  const FlowCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flowsProvider);
    final notifier = ref.read(flowsProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifier.setDimensions(constraints.maxWidth, constraints.maxHeight);
        });

        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 2,
          panEnabled: true,
          scaleEnabled: true,
          onInteractionStart: (details) {
            // notifier.setPanning(true);
          },
          onInteractionEnd: (details) {
            // notifier.setPanning(false);
          },
          child: Stack(
            children: [
              const Lines(),
              if (state.isSelectingLoop &&
                  (state.isPickingLoopFrom || state.isPickingLoopTo))
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.3)),
                ),
              for (var flow in state.flows)
                Positioned(
                  left: flow.x,
                  top: flow.y,
                  child: InkWell(
                    onTap: () {
                      notifier.selectFlow(
                        flow.id,
                        flow.direction,
                        flow.type,
                      );
                    },
                    onHover: (h) {
                      // notifier.setLoopHover(h ? flow.id : -1);
                    },
                    child: _buildFlowWidget(flow, state, notifier),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFlowWidget(
    FlowClass flow,
    FlowsState state,
    FlowsNotifier notifier,
  ) {
    final highlight =
        state.isSelectingLoop &&
        (state.isPickingLoopFrom || state.isPickingLoopTo) &&
        state.loopHoverId == flow.id;
    final cursor = state.isPanning
        ? SystemMouseCursors.grabbing
        : SystemMouseCursors.move;

    final onPanStart = (DragStartDetails details) {
      notifier.startLineHeightDrag(
        flow.id,
        details.globalPosition.dx,
        details.globalPosition.dy,
      );
    };
    final onPanUpdate = (DragUpdateDetails details) {
      notifier.updateLineHeightDrag(
        details.globalPosition.dx,
        details.globalPosition.dy,
      );
    };
    final onPanEnd = (DragEndDetails details) {
      notifier.endLineHeightDrag();
    };

    switch (flow.type) {
      case FlowType.terminal:
        return flow_widgets.Terminal(
          width: flow.width,
          height: flow.height,
          label: flow.value,
          highlight: highlight,
          mouseCursor: cursor,
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
        );
      case FlowType.process:
        return flow_widgets.Process(
          width: flow.width,
          height: flow.height,
          label: flow.value,
          highlight: highlight,
          mouseCursor: cursor,
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
        );
      case FlowType.condition:
        return flow_widgets.Condition(
          width: flow.width,
          height: flow.width,
          label: flow.value,
          highlight: highlight,
          mouseCursor: cursor,
          onPanStart: onPanStart,
          onPanUpdate: onPanUpdate,
          onPanEnd: onPanEnd,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class Lines extends ConsumerWidget {
  const Lines({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flowsProvider);
    final notifier = ref.read(flowsProvider.notifier);

    return SizedBox(
      width: state.stageWidth,
      height: state.windowHeight,
      child: MouseRegion(
        cursor: state.isPanning
            ? SystemMouseCursors.grabbing
            : state.isDraggingLineHeight
            ? SystemMouseCursors.resizeUpDown
            : state.isDraggingLoopPad
            ? (state.hoveredLoopPadAxis == "horizontal"
                  ? SystemMouseCursors.resizeLeftRight
                  : SystemMouseCursors.resizeUpDown)
            : state.hoveredLoopPadAxis == "horizontal"
            ? SystemMouseCursors.resizeLeftRight
            : state.hoveredLoopPadAxis == "vertical"
            ? SystemMouseCursors.resizeUpDown
            : state.isMouseOverDot
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onHover: (event) {
          bool isOverDot =
              state.showAddHandles &&
              _isMouseOverDot(event.localPosition, state);
          notifier.updateMouseOverDot(isOverDot);

          if (state.showAddHandles) {
            _checkProcessFlowHover(event.localPosition, state, notifier);
          }
        },
        onExit: (event) {
          notifier.updateMouseOverDot(false);
          if (state.window != "add" || state.selectedId < 0) {
            notifier.onProcessUnhover();
          }
        },
        child: Listener(
          onPointerDown: (event) {
            if (state.hoveredLoopPadAxis.isNotEmpty) {
              // notifier.startLoopPadDrag(event.position.dx, event.position.dy);
            }
          },
          onPointerMove: (event) {
            if (state.isDraggingLoopPad) {
              // notifier.updateLoopPadDrag(event.position.dx, event.position.dy);
            }
          },
          onPointerUp: (event) {
            // notifier.endLoopPadDrag();
          },
          behavior: HitTestBehavior.translucent,
          child: CanvasTouchDetector(
            gesturesToOverride: const [
              GestureType.onTapDown,
              GestureType.onSecondaryTapDown,
              GestureType.onSecondaryTapUp,
            ],
            builder: (context) {
              return CustomPaint(
                size: Size(state.stageWidth, state.windowHeight),
                painter: LinePainter2(context, state, notifier),
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isMouseOverDot(Offset mousePosition, FlowsState state) {
    const double dotRadius = 10.0;
    for (var flow in state.flows) {
      int consumed = 0;
      if (flow.down.hasChild) consumed++;
      if (flow.left.hasChild) consumed++;
      if (flow.right.hasChild) consumed++;

      bool canAddMore = flow.type != FlowType.condition || consumed < 2;

      // Down dot
      if (!flow.down.hasChild && canAddMore) {
        Offset dotPosition = Offset(
          flow.x + flow.width / 2,
          flow.y + flow.height + flow.down.lineHeight,
        );
        if ((mousePosition - dotPosition).distance <= dotRadius) return true;
      }
      // Right dot
      if (flow.type == FlowType.condition &&
          !flow.right.hasChild &&
          canAddMore) {
        Offset dotPosition = Offset(
          flow.x + flow.width + flow.right.lineHeight,
          flow.y + flow.height / 2,
        );
        if ((mousePosition - dotPosition).distance <= dotRadius) return true;
      }
      // Left dot
      if (flow.type == FlowType.condition &&
          !flow.left.hasChild &&
          canAddMore) {
        Offset dotPosition = Offset(
          flow.x - flow.left.lineHeight,
          flow.y + flow.height / 2,
        );
        if ((mousePosition - dotPosition).distance <= dotRadius) return true;
      }
    }
    return false;
  }

  void _checkProcessFlowHover(
    Offset mousePosition,
    FlowsState state,
    FlowsNotifier notifier,
  ) {
    const double hoverRadius = 15.0;
    for (var flow in state.flows) {
      if (flow.type == FlowType.process) {
        // right side
        Offset rightCenter = Offset(
          flow.x + flow.width + flow.right.lineHeight / 2,
          flow.y + flow.height / 2,
        );
        if ((mousePosition - rightCenter).distance <= hoverRadius) {
          notifier.onProcessHover(flow.id, "right");
          return;
        }
        // left side
        Offset leftCenter = Offset(
          flow.x - flow.left.lineHeight / 2,
          flow.y + flow.height / 2,
        );
        if ((mousePosition - leftCenter).distance <= hoverRadius) {
          notifier.onProcessHover(flow.id, "left");
          return;
        }
      }
    }
    if (state.window != "add" || state.selectedId < 0) {
      notifier.onProcessUnhover();
    }
  }
}

class LinePainter2 extends CustomPainter {
  final BuildContext context;
  final FlowsState state;
  final FlowsNotifier notifier;

  LinePainter2(this.context, this.state, this.notifier);

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    var paint = Paint()
      ..color = Pallet.font2
      ..strokeWidth = 1;

    var highlightPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3;

    final textStyle = TextStyle(color: Pallet.font2, fontSize: 11);
    final yesp = TextPainter(
      text: TextSpan(text: 'yes', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    final nop = TextPainter(
      text: TextSpan(text: 'no', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    // Draw loop links
    for (var loop in state.loopLinks) {
      final fromFlow = state.flows.firstWhere((f) => f.id == loop.fromId);
      final toFlow = state.flows.firstWhere((f) => f.id == loop.toId);

      final start = Offset(
        fromFlow.x + fromFlow.width / 2,
        fromFlow.y + fromFlow.height / 2,
      );
      final end = Offset(
        toFlow.x + toFlow.width / 2,
        toFlow.y + toFlow.height / 2,
      );

      // Draw a curved line or orthogonal line for loop
      final paintLoop = Paint()
        ..color = Colors.grey.withValues(alpha: 0.5)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(start.dx, start.dy);

      // Simple quadratic curve for now to differentiate from regular lines
      final controlPoint = Offset(
        (start.dx + end.dx) / 2 + 50,
        (start.dy + end.dy) / 2,
      );
      path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, end.dx, end.dy);

      canvas.drawPath(path, paintLoop);

      // Draw arrow at end
      final angle = math.atan2(
        end.dy - controlPoint.dy,
        end.dx - controlPoint.dx,
      );
      const arrowSize = 6.0;
      final arrowPath = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(
          end.dx - arrowSize * math.cos(angle - math.pi / 6),
          end.dy - arrowSize * math.sin(angle - math.pi / 6),
        )
        ..lineTo(
          end.dx - arrowSize * math.cos(angle + math.pi / 6),
          end.dy - arrowSize * math.sin(angle + math.pi / 6),
        )
        ..close();
      canvas.drawPath(
        arrowPath,
        Paint()..color = Colors.grey.withValues(alpha: 0.5),
      );
    }

    for (var flow in state.flows) {
      int consumed = 0;
      if (flow.down.hasChild) consumed++;
      if (flow.left.hasChild) consumed++;
      if (flow.right.hasChild) consumed++;

      bool canAddMore = flow.type != FlowType.condition || consumed < 2;

      // 1. Down Line
      Offset startDown = Offset(flow.x + flow.width / 2, flow.y + flow.height);
      Offset endDown = Offset(
        flow.x + flow.width / 2,
        flow.y + flow.height + flow.down.lineHeight,
      );

      bool isHighlightedDown = false;
      if (state.isDraggingLineHeight && state.draggedFlowId >= 0) {
        final draggedIdx = state.flows.indexWhere(
          (f) => f.id == state.draggedFlowId,
        );
        if (draggedIdx != -1) {
          final df = state.flows[draggedIdx];
          isHighlightedDown =
              df.pid == flow.id && df.direction == Direction.down;
        }
      }

      if (flow.down.hasChild || (state.showAddHandles && canAddMore)) {
        canvas.drawLine(
          startDown,
          endDown,
          isHighlightedDown ? highlightPaint : paint,
        );
      }

      if (state.showAddHandles && !flow.down.hasChild && canAddMore) {
        myCanvas.drawCircle(
          endDown,
          3,
          paint,
          onTapDown: (details) {
            notifier.startAddingFlow(flow.id, Direction.down);
          },
        );
      }

      // 2. Right Line
      if (flow.direction != Direction.left &&
          (flow.right.hasChild ||
              (state.showAddHandles &&
                  flow.type == FlowType.condition &&
                  canAddMore))) {
        Offset startRight = Offset(
          flow.x + flow.width,
          flow.y + flow.height / 2,
        );
        Offset endRight = Offset(
          flow.x + flow.width + flow.right.lineHeight,
          flow.y + flow.height / 2,
        );

        bool isHighlightedRight = false;
        if (state.isDraggingLineHeight && state.draggedFlowId >= 0) {
          final draggedIdx = state.flows.indexWhere(
            (f) => f.id == state.draggedFlowId,
          );
          if (draggedIdx != -1) {
            final df = state.flows[draggedIdx];
            isHighlightedRight =
                df.pid == flow.id && df.direction == Direction.right;
          }
        }

        canvas.drawLine(
          startRight,
          endRight,
          isHighlightedRight ? highlightPaint : paint,
        );

        if (state.showAddHandles && !flow.right.hasChild && canAddMore) {
          myCanvas.drawCircle(
            endRight,
            3,
            paint,
            onTapDown: (details) {
              notifier.startAddingFlow(flow.id, Direction.right);
            },
          );
        }
      }

      // 3. Left Line
      if (flow.direction != Direction.right &&
          (flow.left.hasChild ||
              (state.showAddHandles &&
                  flow.type == FlowType.condition &&
                  canAddMore))) {
        Offset startLeft = Offset(flow.x, flow.y + flow.height / 2);
        Offset endLeft = Offset(
          flow.x - flow.left.lineHeight,
          flow.y + flow.height / 2,
        );

        bool isHighlightedLeft = false;
        if (state.isDraggingLineHeight && state.draggedFlowId >= 0) {
          final draggedIdx = state.flows.indexWhere(
            (f) => f.id == state.draggedFlowId,
          );
          if (draggedIdx != -1) {
            final df = state.flows[draggedIdx];
            isHighlightedLeft =
                df.pid == flow.id && df.direction == Direction.left;
          }
        }

        canvas.drawLine(
          startLeft,
          endLeft,
          isHighlightedLeft ? highlightPaint : paint,
        );

        if (state.showAddHandles && !flow.left.hasChild && canAddMore) {
          myCanvas.drawCircle(
            endLeft,
            3,
            paint,
            onTapDown: (details) {
              notifier.startAddingFlow(flow.id, Direction.left);
            },
          );
        }
      }

      // Condition labels (yes/no)
      if (flow.type == FlowType.condition) {
        // Down label
        if (flow.down.hasChild) {
          Offset downLabel = Offset(
            (flow.x + flow.width / 2) + 20,
            (flow.y + flow.height + flow.down.lineHeight / 2) - 10,
          );
          if (flow.yes == Direction.down) {
            yesp.paint(canvas, downLabel);
          } else {
            nop.paint(canvas, downLabel);
          }
        }

        // Right label
        if (flow.right.hasChild) {
          Offset rightLabel = Offset(
            flow.x + flow.width + flow.right.lineHeight / 2 - 10,
            flow.y + flow.height / 2 - 20,
          );
          if (flow.yes == Direction.right) {
            yesp.paint(canvas, rightLabel);
          } else {
            nop.paint(canvas, rightLabel);
          }
        }

        // Left label
        if (flow.left.hasChild) {
          Offset leftLabel = Offset(
            flow.x - flow.left.lineHeight / 2 - 10,
            flow.y + flow.height / 2 - 20,
          );
          if (flow.yes == Direction.left) {
            yesp.paint(canvas, leftLabel);
          } else {
            nop.paint(canvas, leftLabel);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter2 oldDelegate) => true;
}
