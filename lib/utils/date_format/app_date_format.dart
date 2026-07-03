import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AppDateFormat {

 static final context = AppRouter.mainNavigatorKey.currentContext;

 static final currentLanguage = GetIt.I<UserManager>().language == 'de' ? 'de' : 'en';

  static String formatUtcTimestamp(String utcTimestamp) {
    if (utcTimestamp.isNotNullOrNotEmpty) {
      DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
      DateFormat formatter = DateFormat('MM/dd/yyyy - h:mma', currentLanguage);
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
      DateFormat formatter = DateFormat('MMM yyyy',currentLanguage);
      return formatter.format(dateTime);
    }
    return '';
  }

  static String formatUtcToOrder(String utcTimestamp, String currentLanguage) {
  if (utcTimestamp.isNotNullOrNotEmpty) {
    DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    String pattern;
    if (currentLanguage == 'de') {
      pattern = "d. MMMM yyyy 'um' HH:mm";
    } else {
      pattern = "MMMM d, yyyy 'at' h:mma";
    }

    DateFormat formatter = DateFormat(pattern, currentLanguage);
    String formatted = formatter.format(dateTime);
    
    if (currentLanguage != 'de') {
      formatted = formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
    }
    
    return formatted;
  }
  return '';
}

/// Local date for accident summary cards (e.g. Apr 24, 2024).
  static String formatMonthDateYear(String utcTimestamp) {
     if (utcTimestamp.isNotNullOrNotEmpty) {
         DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    return DateFormat('MMM d, yyyy', currentLanguage).format(dateTime.toLocal());
  }
  return '';
  }
  /// Local date for accident summary cards (e.g. Apr 24, 2024).
  static String formatAccidentCardDate(DateTime dateTime) {
    return DateFormat('MMM d, yyyy', currentLanguage).format(dateTime.toLocal());
  }

  /// Local time for accident summary cards (e.g. 9:41 AM).
  static String formatAccidentCardTime(DateTime dateTime) {
    return DateFormat('h:mm a', currentLanguage).format(dateTime.toLocal());
  }



static String convertToIsoFormat(String dateString) {
  try {
    DateFormat inputFormat = DateFormat("MMM dd, yyyy", currentLanguage);
    
    DateTime parsedDate = inputFormat.parse(dateString);
    
    return DateFormat("yyyy-MM-dd").format(parsedDate);
  } catch (e) {
    return AppLocalizations.of(context!)!.invalidDateFormat;
  }
}


static String convertTo24Hour(String time12) {
  try {
    DateFormat inputFormat = DateFormat("hh:mm a", currentLanguage);
    DateTime date = inputFormat.parse(time12);
    return DateFormat("HH:mm").format(date);
  } catch (e) {
    return AppLocalizations.of(context!)!.invalidTime;
  }
}

/// Formats date to month and day only (e.g. Oct 24).
static String formatMonthDay(String utcTimestamp) {
  if (utcTimestamp.isNotNullOrNotEmpty) {
    DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    DateFormat formatter = DateFormat('MMM dd', currentLanguage);
    return formatter.format(dateTime);
  }
  return '';
}

/// Formats time from 24-hour format (e.g. 16:25:00) to 12-hour format (e.g. 4:25 PM).
static String formatTime(String time24) {
  try {
    if (time24.isNotNullOrNotEmpty) {
      DateFormat inputFormat = DateFormat('HH:mm:ss', currentLanguage);
      DateTime dateTime = inputFormat.parse(time24);
      DateFormat outputFormat = DateFormat('h:mm a', currentLanguage);
      return outputFormat.format(dateTime);
    }
    return '';
  } catch (e) {
    return AppLocalizations.of(context!)!.invalidTime;
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
      return AppLocalizations.of(context!)!.justNow;
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes ${AppLocalizations.of(context!)!.minuteTitle} ${AppLocalizations.of(context!)!.agoTitle}';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours ${AppLocalizations.of(context!)!.hourTitle} ${AppLocalizations.of(context!)!.agoTitle}';
    } else if (difference.inDays < 30) {
      int days = difference.inDays;
      return '$days ${AppLocalizations.of(context!)!.dayTitle} ${AppLocalizations.of(context!)!.agoTitle}';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months ${AppLocalizations.of(context!)!.monthTitle} ${AppLocalizations.of(context!)!.agoTitle}';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years ${AppLocalizations.of(context!)!.yearTitle} ${AppLocalizations.of(context!)!.agoTitle}';
    }
  } catch (e) {
    return '';
  }
}

//  static String timeAgo(String isoDateString) {
//   try {
//     if (isoDateString.isEmpty) {
//       return '';
//     }

//     DateTime givenDate = DateTime.parse(isoDateString).toLocal();
//     DateTime now = DateTime.now();
//     Duration difference = now.difference(givenDate);

//     if (difference.inSeconds < 60) {
//       return AppLocalizations.of(context!)!.justNow;
//     } else if (difference.inMinutes < 60) {
//       int minutes = difference.inMinutes;
//       return '$minutes ${AppLocalizations.of(context!).minute}${minutes > 1 ? 's' : ''} ${AppLocalizations.of(context!).ago}';
//     } else if (difference.inHours < 24) {
//       int hours = difference.inHours;
//       return '$hours ${AppLocalizations.of(context!).hour}${hours > 1 ? 's' : ''} ${AppLocalizations.of(context!).ago}';
//     } else if (difference.inDays < 30) {
//       int days = difference.inDays;
//       return '$days ${AppLocalizations.of(context!).day}${days > 1 ? 's' : ''} ${AppLocalizations.of(context!).ago}';
//     } else if (difference.inDays < 365) {
//       int months = (difference.inDays / 30).floor();
//       return '$months ${AppLocalizations.of(context!).month}${months > 1 ? 's' : ''} ${AppLocalizations.of(context!).ago}';
//     } else {
//       int years = (difference.inDays / 365).floor();
//       return '$years ${AppLocalizations.of(context!).year}${years > 1 ? 's' : ''} ${AppLocalizations.of(context!).ago}';
//     }
//   } catch (e) {
//     return '';
//   }
// }
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
