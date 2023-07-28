import 'package:flutter/material.dart';

enum DialogAnimationType { curveEaseInOutBack, scale }

/// Show dialog with animation and future delay awareness.
void showAnimatedDialog(
  BuildContext context, {
  bool barrierDismissible = false,
  String? barrierLabel,
  Color? barrierColor,
  Duration transitionDuration = const Duration(milliseconds: 200),
  DialogAnimationType animType = DialogAnimationType.curveEaseInOutBack,
  required Widget dialog,
  bool shouldDelay = false,
}) {
  if (shouldDelay) {
    Future.delayed(Duration.zero).then((value) {
      showDialogWithAnimation(
        context,
        dialog: dialog,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        animType: animType,
      );
    });
  } else {
    showDialogWithAnimation(
      context,
      dialog: dialog,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      animType: animType,
    );
  }
}

/// Show dialog with some animation
void showDialogWithAnimation(
  BuildContext context, {
  bool barrierDismissible = false,
  String? barrierLabel,
  Color? barrierColor,
  Duration transitionDuration = const Duration(milliseconds: 200),
  DialogAnimationType animType = DialogAnimationType.curveEaseInOutBack,
  required Widget dialog,
}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) => dialog,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor ?? const Color(0x80000000),
    transitionDuration: transitionDuration,
    transitionBuilder: (context, anim1, anim2, child) {
      if (animType == DialogAnimationType.curveEaseInOutBack) {
        final curveValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curveValue * 200, 0.0),
          child: Opacity(
            opacity: anim1.value,
            child: dialog,
          ),
        );
      } else if (animType == DialogAnimationType.scale) {
        return Transform.scale(
          scale: anim1.value,
          child: Opacity(
            opacity: anim1.value,
            child: dialog,
          ),
        );
      } else {
        return dialog;
      }
    },
  );
}

/// Show [TimeOfDay] picker with `easeInOutBack` curve animation.
Future<TimeOfDay?> showAnimatedTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  String? cancelText,
  String? confirmText,
  String? helpText,
  String? errorInvalidText,
  String? hourLabelText,
  String? minuteLabelText,
  EntryModeChangeCallback? onEntryModeChanged,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) async {
  assert(debugCheckHasMaterialLocalizations(context));

  final Widget dialog = TimePickerDialog(
    initialTime: initialTime,
    initialEntryMode: initialEntryMode,
    cancelText: cancelText,
    confirmText: confirmText,
    helpText: helpText,
    errorInvalidText: errorInvalidText,
    hourLabelText: hourLabelText,
    minuteLabelText: minuteLabelText,
    onEntryModeChanged: onEntryModeChanged,
  );

  return showGeneralDialog<TimeOfDay?>(
    context: context,
    pageBuilder: (context, a1, a2) => dialog,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (conext, anim1, anim2, child) {
      final curveValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curveValue * 200, 0.0),
        child: Opacity(
          opacity: anim1.value,
          child: dialog,
        ),
      );
    },
  );
}

/// Show [DateTime] picker with `easeInOutBack` curve animation.
Future<DateTime?> showAnimatedDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  DateTime? currentDate,
  DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  SelectableDayPredicate? selectableDayPredicate,
  String? helpText,
  String? cancelText,
  String? confirmText,
  Locale? locale,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextDirection? textDirection,
  TransitionBuilder? builder,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  String? errorFormatText,
  String? errorInvalidText,
  String? fieldHintText,
  String? fieldLabelText,
  TextInputType? keyboardType,
  Offset? anchorPoint,
}) async {
  initialDate = DateUtils.dateOnly(initialDate);
  firstDate = DateUtils.dateOnly(firstDate);
  lastDate = DateUtils.dateOnly(lastDate);
  assert(
    !lastDate.isBefore(firstDate),
    'lastDate $lastDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isBefore(firstDate),
    'initialDate $initialDate must be on or after firstDate $firstDate.',
  );
  assert(
    !initialDate.isAfter(lastDate),
    'initialDate $initialDate must be on or before lastDate $lastDate.',
  );
  assert(
    selectableDayPredicate == null || selectableDayPredicate(initialDate),
    'Provided initialDate $initialDate must satisfy provided selectableDayPredicate.',
  );
  assert(debugCheckHasMaterialLocalizations(context));

  Widget dialog = DatePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    currentDate: currentDate,
    initialEntryMode: initialEntryMode,
    selectableDayPredicate: selectableDayPredicate,
    helpText: helpText,
    cancelText: cancelText,
    confirmText: confirmText,
    initialCalendarMode: initialDatePickerMode,
    errorFormatText: errorFormatText,
    errorInvalidText: errorInvalidText,
    fieldHintText: fieldHintText,
    fieldLabelText: fieldLabelText,
    keyboardType: keyboardType,
  );

  if (textDirection != null) {
    dialog = Directionality(
      textDirection: textDirection,
      child: dialog,
    );
  }

  if (locale != null) {
    dialog = Localizations.override(
      context: context,
      locale: locale,
      child: dialog,
    );
  }

  return showGeneralDialog<DateTime?>(
    context: context,
    pageBuilder: (context, a1, a2) => dialog,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (conext, anim1, anim2, child) {
      final curveValue = Curves.easeInOutBack.transform(anim1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0.0, curveValue * 200, 0.0),
        child: Opacity(
          opacity: anim1.value,
          child: dialog,
        ),
      );
    },
  );
}
