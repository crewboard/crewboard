import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';

import 'ticket_threads_full_view.dart';

// How many pixels represent one day
const double _kDayWidth = 40.0;

class TicketGanttChart extends ConsumerWidget {
  final ScrollController? scrollController;
  const TicketGanttChart({super.key, this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(plannerProvider.select((s) => s.allTickets))
        .where((t) => t.holder != 'true')
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kPlannerHeaderHeight),
        if (tickets.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                'No tickets',
                style: TextStyle(color: Pallet.font3, fontSize: 12),
              ),
            ),
          )
        else
          Expanded(
            child: _GanttBody(
              tickets: tickets,
              scrollController: scrollController,
            ),
          ),
      ],
    );
  }
}

class _GanttBody extends StatefulWidget {
  final List<PlannerTicket> tickets;
  final ScrollController? scrollController;
  const _GanttBody({required this.tickets, this.scrollController});

  @override
  State<_GanttBody> createState() => _GanttBodyState();
}

class _GanttBodyState extends State<_GanttBody> {
  late ScrollController _scrollController;

  // viewStart is the leftmost visible date
  late DateTime _viewStart;

  @override
  void initState() {
    super.initState();
    // Start 5 days before today so today is roughly centered and bars are visible
    final now = DateTime.now();
    _viewStart = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 5));
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final isShiftPressed = HardwareKeyboard.instance.logicalKeysPressed.any(
        (key) => key == LogicalKeyboardKey.shiftLeft || key == LogicalKeyboardKey.shiftRight
      );
      
      final bool isHorizontalTrackpadScroll = event.scrollDelta.dx.abs() > event.scrollDelta.dy.abs();

      if (isShiftPressed || isHorizontalTrackpadScroll) {
        final delta = event.scrollDelta.dx != 0 ? event.scrollDelta.dx : event.scrollDelta.dy;
        final daysToShift = (delta / _kDayWidth).round();
        if (daysToShift != 0) {
          setState(() {
            _viewStart = _viewStart.add(Duration(days: daysToShift));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          final visibleDays = (totalWidth / _kDayWidth).ceil() + 1;
          final now = DateTime.now();
          final nowOffset = now.difference(_viewStart).inHours.toDouble() / 24.0 * _kDayWidth;

          return Column(
            children: [
              // Date header
              SizedBox(
                height: kPlannerDateHeaderHeight,
                child: Column(
                  children: [
                    Expanded(
                      child: _DateHeader(
                        viewStart: _viewStart,
                        visibleDays: visibleDays,
                      ),
                    ),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.06),
                      height: 1,
                    ),
                  ],
                ),
              ),
              // Ticket rows
              Expanded(
                child: Stack(
                  children: [
                    // Today line
                    Positioned(
                      left: nowOffset,
                      top: 0,
                      bottom: 0,
                      width: 1,
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      itemCount: widget.tickets.length,
                      itemBuilder: (context, index) {
                        return _GanttRow(
                          ticket: widget.tickets[index],
                          viewStart: _viewStart,
                          visibleDays: visibleDays,
                          totalWidth: totalWidth,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  final DateTime viewStart;
  final int visibleDays;

  const _DateHeader({required this.viewStart, required this.visibleDays});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visibleDays,
        itemBuilder: (context, i) {
          final day = viewStart.add(Duration(days: i));
          final isToday = day.year == today.year &&
              day.month == today.month &&
              day.day == today.day;
          final isMonthStart = day.day == 1;

          return SizedBox(
            width: _kDayWidth,
            child: Container(
              decoration: isToday
                  ? BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.15),
                    )
                  : null,
              alignment: Alignment.center,
              child: Text(
                isMonthStart
                    ? '${_monthAbbr(day.month)} ${day.day}'
                    : '${day.day}',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: isToday ? Colors.blue : Pallet.font3,
                  fontWeight: isToday || isMonthStart
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _monthAbbr(int m) =>
      ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}

class _GanttRow extends ConsumerWidget {
  final PlannerTicket ticket;
  final DateTime viewStart;
  final int visibleDays;
  final double totalWidth;

  const _GanttRow({
    required this.ticket,
    required this.viewStart,
    required this.visibleDays,
    required this.totalWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine bar position relative to viewStart
    final start = ticket.createdAt ?? DateTime.now();
    DateTime end = ticket.deadline != null
        ? DateTime.parse(ticket.deadline!)
        : start.add(const Duration(days: 3));
    
    // Ensure end is never before start
    if (end.isBefore(start)) end = start.add(const Duration(hours: 1));

    final startDayOffset = start.difference(viewStart).inHours.toDouble() / 24.0;
    final endDayOffset = end.difference(viewStart).inHours.toDouble() / 24.0;

    final barLeft = startDayOffset * _kDayWidth;
    final barRight = endDayOffset * _kDayWidth;

    final now = DateTime.now();
    final nowOffset = now.difference(viewStart).inHours.toDouble() / 24.0 * _kDayWidth;

    // Use completion time for evaluation if available, otherwise use now
    final evaluationTime = ticket.completed 
        ? (ticket.completedAt ?? now) 
        : now;
    final isOverdue = !evaluationTime.isBefore(end);

    // Only render bar if it overlaps the visible range
    final visibleWidth = visibleDays * _kDayWidth;
    
    // If overdue, the bar extends to either the completion time or current time
    double furthestRight;
    if (isOverdue) {
      if (ticket.completed && ticket.completedAt != null) {
        furthestRight = ticket.completedAt!.difference(viewStart).inHours.toDouble() / 24.0 * _kDayWidth;
      } else {
        furthestRight = nowOffset;
      }
    } else {
      furthestRight = barRight;
    }

    // Ensure we check against a sane 'right' value
    final effectiveRight = furthestRight < barLeft ? barLeft + _kDayWidth : furthestRight;
    final isVisible = effectiveRight >= 0 && barLeft < visibleWidth;

    // Determine the base bar color and range
    final Color baseColor = isOverdue 
        ? Colors.red.withValues(alpha: 0.7) 
        : Colors.grey.shade600.withValues(alpha: 0.5);
    
    // The base bar should cover the "planned" duration PLUS any overdue time
    final double baseRight = isOverdue ? nowOffset : barRight;

    return InkWell(
      onTap: () {
          ref.read(plannerProvider.notifier).setSelectedTicketId(ticket.id);
          ref.read(plannerProvider.notifier).getTicketThread(ticket.id);
      },
      child: Container(
        height: kPlannerRowHeight,
        alignment: Alignment.center,
        child: SizedBox(
          height: 30,
          width: totalWidth,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              if (isVisible) ...[
                // 1. BASE BAR — Grey (Planned) or Red (Overdue & Never Started)
                _buildBar(
                  barLeft, baseRight, totalWidth,
                  baseColor,
                  tooltip: '${_fmt(start)} → ${_fmt(end)}',
                  hasBorder: true,
                ),
  
                // 2. BLUE OVERLAY — Working progress (on top of base)
                if (ticket.working)
                  _buildBar(
                    barLeft, nowOffset, totalWidth,
                    Colors.blue.withValues(alpha: 0.4),
                  ),
  
                // 3. RED OVERLAY — Exceeded portion (on top of base/blue)
                if (isOverdue && ticket.working)
                  _buildBar(
                    barRight, nowOffset, totalWidth,
                    Colors.red.withValues(alpha: 0.6),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBar(double left, double right, double totalWidth, Color color, {String? tooltip, bool hasBorder = false}) {
    final barWidth = (right - left).clamp(8.0, totalWidth);
    if (barWidth <= 0) return const SizedBox.shrink();

    // Don't clamp — let the Stack's Clip.hardEdge handle edge clipping
    Widget bar = Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: hasBorder 
            ? Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1)
            : null,
      ),
    );

    if (tooltip != null) {
      bar = Tooltip(message: tooltip, child: bar);
    }

    return Positioned(
      left: left,
      width: barWidth,
      top: 0,
      bottom: 0,
      child: bar,
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
