import 'package:intl/intl.dart';

class DateFormatChange{

  static final List<DateFormat> _formatsToTry = [
    DateFormat('d-M-yyyy'),
    DateFormat('dd-MM-yyyy'),
    DateFormat('d-MM-yyyy'),
    DateFormat('dd-M-yyyy'),
    DateFormat('d-M-yy'),
    DateFormat('dd-MM-yy'),
    DateFormat('d-MM-yy'),
    DateFormat('dd-M-yy'),
    DateFormat('dd/MM/yyyy'),
    DateFormat('d/M/yy'),
    DateFormat('d MMM yyyy'),
    DateFormat('d MMMM yyyy'),
    DateFormat('yyyy-MM-dd'),
    DateFormat('yyyy/MM/dd'),
    DateFormat('yyyy.MM.dd'),
  ];

  static String normalizeToYyyyMmDd(String inputDate) {
    for (final format in _formatsToTry) {
      try {
        final date = format.parseStrict(inputDate);
        return DateFormat('yyyy-MM-dd').format(date);
      } catch (e) {
        // continue trying other formats
      }
    }
    final parts = inputDate.split(RegExp(r'[-/. ]'));
    if (parts.length == 3) {
      try {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);

        // Convert 1- or 2-digit year to 4-digit
        if (year < 100) {
          year += (year <= 30) ? 2000 : 1900;
        }

        final date = DateTime(year, month, day);
        return DateFormat('yyyy-MM-dd').format(date);
      } catch (_) {}
    }
    // If no format matches, return the original string
    return inputDate;
  }

  String formatReadableDate({required String inputDate}) {
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parseStrict(inputDate);
      final day = parsedDate.day;
      final suffix = _getDaySuffix(day);
      final formatted = DateFormat('MMMM, yyyy').format(parsedDate);
      return '$day$suffix $formatted';
    } catch (e) {
      return inputDate; // If parsing fails, return original string
    }
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

}