import 'package:flutter/material.dart';

class DatePickerService {
  static Future<DateTime?> pickDob(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime defaultInitialDate = DateTime(now.year - 18, now.month, now.day);

    return showDatePicker(
      context: context,
      initialDate: initialDate ?? defaultInitialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        final ThemeData theme = Theme.of(context);
        return Theme(
          data: theme.copyWith(
            datePickerTheme: theme.datePickerTheme.copyWith(
              headerHeadlineStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              headerHelpStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              weekdayStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              dayStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              yearStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }

  static String formatForDisplay(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  static String formatForApi(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
