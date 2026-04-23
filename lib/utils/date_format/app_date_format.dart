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


static String formatUtcToOrder(String utcTimestamp) {
  if (utcTimestamp.isNotNullOrNotEmpty) {
    DateTime dateTime = DateTime.parse(utcTimestamp).toLocal();
    DateFormat formatter = DateFormat("MMMM d, yyyy 'at' h:mma");
    String formatted = formatter.format(dateTime);
    return formatted.replaceAll('AM', 'am').replaceAll('PM', 'pm');
  }
  return '';
}

}
