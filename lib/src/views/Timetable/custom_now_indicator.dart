import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timetable/timetable.dart';

class CustomNowIndicator extends StatelessWidget {
  const CustomNowIndicator({
    Key? key,
    this.child,
    required this.color,
  }) : super(key: key);
  final Widget? child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _CustomNowIndicatorPainter(
        controller: DefaultDateController.of(context)!,
        devicePixelRatio: context.mediaQuery.devicePixelRatio,
        repaintNotifier: ValueNotifier<DateTime>(DateTimeTimetable.now()),
        color: color,
      ),
      child: child,
    );
  }
}

class _CustomNowIndicatorPainter extends CustomPainter {
  final DateController controller;
  final Paint _paint;
  final double devicePixelRatio;
  final ValueNotifier<DateTime> _repaintNotifier;
  _CustomNowIndicatorPainter({
    required this.controller,
    required this.devicePixelRatio,
    required ValueNotifier<DateTime> repaintNotifier,
    required Color color,
  })  : _paint = Paint()
          ..color = color
          ..strokeWidth = 1,
        _repaintNotifier = repaintNotifier,
        super(repaint: Listenable.merge([controller, repaintNotifier]));
  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTimeTimetable.now();
    final y = now.timeOfDay.inMinutes / Duration.minutesPerDay * size.height;
    final maxDistance = 0.5 / devicePixelRatio;
    final delay = const Duration(days: 1) * (maxDistance / size.height);
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      _paint,
    );
    Future.delayed(
      delay,
      () => _repaintNotifier.value = DateTimeTimetable.now(),
    );
  }

  @override
  bool shouldRepaint(_CustomNowIndicatorPainter oldDelegate) =>
      devicePixelRatio != oldDelegate.devicePixelRatio;
}
