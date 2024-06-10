import 'package:flutter/cupertino.dart';
import 'package:timetable/timetable.dart';

class DragInfo extends InheritedWidget {
  const DragInfo({
    Key? key,
    required this.context,
    required this.dateController,
    required this.size,
    required Widget child,
  }) : super(key: key, child: child);

  // Storing the context feels wrong but I haven't found a different way to
  // transform global coordinates back to local ones in this context.
  final BuildContext context;
  final DateController dateController;
  final Size size;

  static DateTime resolveOffset(BuildContext context, Offset globalOffset) {
    final dragInfos = context.dependOnInheritedWidgetOfExactType<DragInfo>()!;

    final localOffset = (dragInfos.context.findRenderObject()! as RenderBox)
        .globalToLocal(globalOffset);
    final pageValue = dragInfos.dateController.value;
    final page = (pageValue.page +
            localOffset.dx / dragInfos.size.width * pageValue.visibleDayCount)
        .floor();
    return DateTimeTimetable.dateFromPage(page).add(
      Duration(
        minutes:
            (Duration.minutesPerDay * (localOffset.dy / dragInfos.size.height))
                .toInt(),
      ),
    );
  }

  @override
  bool updateShouldNotify(DragInfo oldWidget) {
    return context != oldWidget.context ||
        dateController != oldWidget.dateController ||
        size != oldWidget.size;
  }
}
