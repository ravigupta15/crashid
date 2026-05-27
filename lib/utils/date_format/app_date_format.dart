import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:intl/intl.dart';

class AppDateFormat {
  static String formatUtcTimestamp(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat('MM/dd/yyyy - h:mma');
      return formatter.format(dateTime);
    }
    return '';
  }

  static String formatDob(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat('MM/dd/yyyy');
      return formatter.format(dateTime);
    }
    return '';
  }

  
  static String formatDate(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    }
    return '';
  }

  
  static String formatMonthYear(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat('MMM yyyy');
      return formatter.format(dateTime);
    }
    return '';
  }

  static String formatUtcToOrder(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat("MMMM d, yyyy 'at' h:mma");
      String formatted = formatter.format(dateTime);
      return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
    }
    return '';
  }

/// Local date for accident summary cards (e.g. Apr 24, 2024).
  static String formatMonthDateYear(String utcTimestamp) {
     if (utcTimestamp.isNotNullOrNotEmpty) {
         DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    return DateFormat('MMM d, yyyy').format(dateTime.toLocal());
  }
  return '';
  }
  /// Local date for accident summary cards (e.g. Apr 24, 2024).
  static String formatAccidentCardDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime.toLocal());
  }

  /// Local time for accident summary cards (e.g. 9:41 AM).
  static String formatAccidentCardTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime.toLocal());
  }



static String convertToIsoFormat(String dateString) {
  try {
    DateFormat inputFormat = DateFormat("MMMM dd, yyyy");
    
    DateTime parsedDate = inputFormat.parse(dateString);
    
    return DateFormat("yyyy-MM-dd").format(parsedDate);
  } catch (e) {
    return "Invalid Date Format";
  }
}


static String convertTo24Hour(String time12) {
  try {
    DateFormat inputFormat = DateFormat("hh:mm a");
    DateTime date = inputFormat.parse(time12);
    return DateFormat("HH:mm").format(date);
  } catch (e) {
    return "Invalid Time";
  }
}

/// Formats date to month and day only (e.g. Oct 24).
static String formatMonthDay(String utcTimestamp) {
  if (utcTimestamp.isNotNullOrNotEmpty) {
    DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    DateFormat formatter = DateFormat('MMM dd');
    return formatter.format(dateTime);
  }
  return '';
}

/// Formats time from 24-hour format (e.g. 16:25:00) to 12-hour format (e.g. 4:25 PM).
static String formatTime(String time24) {
  try {
    if (time24.isNotNullOrNotEmpty) {
      DateFormat inputFormat = DateFormat('HH:mm:ss');
      DateTime dateTime = inputFormat.parse(time24);
      DateFormat outputFormat = DateFormat('h:mm a');
      return outputFormat.format(dateTime);
    }
    return '';
  } catch (e) {
    return 'Invalid Time';
  }
}

 static String timeAgo(String isoDateString) {
  try {
    if (isoDateString.isEmpty) {
      return '';
    }

    DateTime givenDate = DateTime.parse(isoDateString).toLocal();
    DateTime now = DateTime.now();
    Duration difference = now.difference(givenDate);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      int days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  } catch (e) {
    return '';
  }
}
}


class DurationDifference {
  final int years;
  final int months;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  DurationDifference({
    required this.years,
    required this.months,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });
}
bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      }
      return false;
    }
    return true;
  }
  return false;
}
